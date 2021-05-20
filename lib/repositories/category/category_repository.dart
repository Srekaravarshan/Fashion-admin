import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion/config/paths.dart';
import 'package:fashion/models/category_item_model.dart';
import 'package:fashion/repositories/category/base_category_repository.dart';
import 'package:firebase_database/firebase_database.dart';

class CategoryRepository extends BaseCategoryRepository {
  final DatabaseReference _databaseReference;
  CategoryRepository({DatabaseReference? databaseReference})
      : _databaseReference =
            databaseReference ?? FirebaseDatabase.instance.reference();

  @override
  Future<void> createCategoryItem(
      {required CategoryItem item,
      required CollectionReference reference}) async {
    // await reference.add(item.toDocument());
    _databaseReference.child(Paths.category).set(item);
  }

  @override
  Stream<List<CategoryItem?>> getCategoryItems(
      {required CollectionReference reference}) {
    print(reference.path);
    reference.snapshots().forEach((snap) => print(snap.docs.length));
    return reference.snapshots().map((snap) =>
        snap.docs.map((doc) => CategoryItem.fromDocument(doc)).toList());
  }
}
