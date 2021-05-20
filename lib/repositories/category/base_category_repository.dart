import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/models/models.dart';

abstract class BaseCategoryRepository {
  Future<void> createCategoryItem(
      {required CategoryItem item, required CollectionReference reference});
  Stream<List<CategoryItem?>> getCategoryItems(
      {required CollectionReference reference});
}
