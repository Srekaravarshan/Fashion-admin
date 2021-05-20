part of 'category_bloc.dart';

enum CategoryStatus { initial, loading, loaded, error }

class CategoryState extends Equatable {
  final List<CategoryItem?> categories;
  final CategoryStatus status;
  final Failure failure;
  final CollectionReference reference;
  final List<Widget>? categoryStacks;
  final int index;

  const CategoryState(
      {required this.categories,
      required this.status,
      required this.failure,
      required this.reference,
      required this.categoryStacks,
      required this.index});

  factory CategoryState.initial() {
    return CategoryState(
        categories: [],
        status: CategoryStatus.initial,
        failure: Failure(),
        reference: FirebaseFirestore.instance.collection(Paths.category),
        categoryStacks: [],
        index: -1);
  }

  @override
  List<Object> get props => [categories, status, failure, reference];

  String? get id => null;

  CategoryState copyWith(
      {List<CategoryItem?>? categories,
      CategoryStatus? status,
      Failure? failure,
      CollectionReference? reference,
      List<Widget>? categoryStacks,
      int? index}) {
    return CategoryState(
        categories: categories ?? this.categories,
        status: status ?? this.status,
        failure: failure ?? this.failure,
        reference: reference ?? this.reference,
        categoryStacks: categoryStacks ?? this.categoryStacks,
        index: index ?? this.index);
  }

  List<Widget>? addCategoryStack(
      Stream<List<CategoryItem?>> list, BuildContext context) {
    this.categoryStacks!.add(catagoryStreamListView(this, list, context));
    return this.categoryStacks;
  }
}
