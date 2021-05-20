part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategory extends CategoryEvent {
  final CollectionReference reference;
  LoadCategory({required this.reference});
}

class AddCategory extends CategoryEvent {
  final String category;
  final bool isCategory;
  final CollectionReference reference;
  AddCategory(
      {required this.category,
      required this.isCategory,
      required this.reference});
}

class UpdateCategories extends CategoryEvent {
  final List<CategoryItem?> categories;

  const UpdateCategories({required this.categories});
}

class AddStack extends CategoryEvent {
  final CollectionReference reference;
  final BuildContext context;
  AddStack({required this.reference, required this.context});
}
