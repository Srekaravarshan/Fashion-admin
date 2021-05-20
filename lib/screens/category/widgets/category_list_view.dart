import 'package:fashion/models/category_item_model.dart';
import 'package:fashion/screens/category/bloc/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget catagoryStreamListView(CategoryState state,
    Stream<List<CategoryItem?>> list, BuildContext context) {
  return StreamBuilder<List<CategoryItem?>>(
      stream: list,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        return categoryListView(state, snapshot.data, context);
      });
}

Widget categoryListView(
    CategoryState state, List<CategoryItem?>? list, BuildContext context) {
  return SizedBox(
    height: 600,
    child: ListView.builder(
      itemCount: list!.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
          context.read<CategoryBloc>().add(AddStack(
              reference: state.reference
                  .doc(list[index]!.id)
                  .collection(list[index]!.id!),
              context: context));
        },
        child: ListTile(
          title: Text(list[index]!.title),
          trailing: Icon(Icons.arrow_right),
        ),
      ),
    ),
  );
}
