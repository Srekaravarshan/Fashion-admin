import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/config/paths.dart';
import 'package:fashion/repositories/category/category_repository.dart';
import 'package:fashion/screens/category/bloc/category_bloc.dart';
import 'package:fashion/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Category extends StatefulWidget {
  static const String routeName = '/category';

  static Route route() {
    return MaterialPageRoute(
        builder: (context) => BlocProvider<CategoryBloc>(
              create: (_) => CategoryBloc(
                  categoryRepository: context.read<CategoryRepository>())
                ..add(AddStack(
                    reference:
                        FirebaseFirestore.instance.collection(Paths.category),
                    context: context)),
              child: Category(),
            ),
        settings: RouteSettings(name: routeName));
  }

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
      if (state.status == CategoryStatus.error) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(content: state.failure.message),
        );
      }
    }, builder: (context, state) {
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            drawer: NavigationDrawer(),
            appBar: AppBar(
              title: Text('Category'),
            ),
            body: _buildBody(state)),
      );
    });
  }

  Widget _buildBody(CategoryState state) {
    return state.status == CategoryStatus.loading ||
            state.categoryStacks == null ||
            state.categoryStacks!.isEmpty
        ? Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () => {_categoryDialog(state.reference)},
                        child: Text('New Category')),
                    ElevatedButton(onPressed: () {}, child: Text('New Item')),
                  ],
                ),
                SizedBox(height: 20),
                IndexedStack(
                    children: state.categoryStacks ?? [Container()],
                    index: state.index),
                // categoryListView(state, state.categories)
              ],
            ),
          );
  }

  void _categoryDialog(CollectionReference reference) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>()),
          child: CategoryDialog(
            reference: reference,
          ),
        );
      },
    );
  }
}

class CategoryDialog extends StatefulWidget {
  final CollectionReference reference;

  const CategoryDialog({required this.reference});

  @override
  _CategoryDialogState createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<CategoryDialog> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return AlertDialog(
          title: Text('Add Category'),
          content: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(),
                child: TextFormField(
                  controller: _controller,
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Category cannot be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(), labelText: 'Category'),
                ),
              )),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<CategoryBloc>().add(AddCategory(
                        category: _controller.text.trim(),
                        isCategory: true,
                        reference: widget.reference));
                    Navigator.pop(context);
                  }
                },
                child: Text('Add')),
          ],
        );
      },
    );
  }
}
