import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CategoryItem extends Equatable {
  final String? id;
  final String title;
  final bool isCategory;
  final CollectionReference? reference;
  final List<dynamic> products;

  CategoryItem(
      {this.id,
      required this.title,
      required this.isCategory,
      this.reference,
      required this.products});

  Map<String, dynamic> toDocument() {
    return {
      'title': title,
      'isCategory': isCategory,
      'products': products,
    };
  }

  static CategoryItem? fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    return CategoryItem(
        id: doc.id,
        title: data!['title'] ?? '',
        isCategory: data['isCategory'] ?? null,
        products: data['products'] ?? []);
  }

  CategoryItem copyWith({
    required String id,
    required String title,
    required bool isCategory,
    required CollectionReference reference,
    required List<dynamic> products,
  }) {
    if ((identical(id, this.id)) &&
        (identical(title, this.title)) &&
        (identical(isCategory, this.isCategory)) &&
        (identical(reference, this.reference)) &&
        (identical(products, this.products))) {
      return this;
    }

    return new CategoryItem(
      id: id,
      title: title,
      isCategory: isCategory,
      reference: reference,
      products: products,
    );
  }

  @override
  List<Object> get props => [title, isCategory, products];
}
