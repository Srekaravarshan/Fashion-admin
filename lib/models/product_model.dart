import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final DateTime publishedDate;
  final List reviews;
  final double rating;
  final int stock;
  final String manufacturer;
  final double price;
  final double mrp;
  final String mainImageUrl;
  final List additionImages;
  final String description;
  final List features;
  final List keywords;
  final String department;
  final String type;
  final Map moreDetails;

  Product(
      {required this.id,
      required this.title,
      required this.publishedDate,
      required this.reviews,
      required this.rating,
      required this.stock,
      required this.manufacturer,
      required this.price,
      required this.mrp,
      required this.mainImageUrl,
      required this.additionImages,
      required this.description,
      required this.features,
      required this.keywords,
      required this.department,
      required this.type,
      required this.moreDetails});

  Map<dynamic, dynamic> toDocument() {
    Map doc = {
      'id': id,
      'title': title,
      'publishedDate': publishedDate,
      'reviews': reviews,
      'rating': rating,
      'stock': stock,
      'manufacturer': manufacturer,
      'price': price,
      'mrp': mrp,
      'mainImageUrl': mainImageUrl,
      'additionImages': additionImages,
      'description': description,
      'features': features,
      'keywords': keywords,
      'department': department,
      'type': type,
    };
    doc.addAll(moreDetails);

    return doc;
  }

  static Future<Product> fromDocument(DocumentSnapshot doc) async {
    final data = doc.data();
    return Product(
        id: doc.id,
        title: data!['title'] ?? '',
        publishedDate: data['publishedDate'] ?? null,
        reviews: data['reviews'] ?? [],
        rating: data['rating'] ?? 0,
        stock: data['stock'] ?? 0,
        manufacturer: data['manufacturer'] ?? '',
        price: data['price'] ?? 0,
        mrp: data['mrp'] ?? 0,
        mainImageUrl: data['mainImageUrl'] ?? '',
        additionImages: data['additionImages'] ?? [],
        description: data['description'] ?? '',
        features: data['features'] ?? [],
        keywords: data['keywords'] ?? [],
        department: data['department'] ?? '',
        type: data['type'] ?? '',
        moreDetails: {});
  }

  Product copyWith({
    String? id,
    String? title,
    DateTime? publishedDate,
    List? reviews,
    double? rating,
    int? stock,
    String? manufacturer,
    double? price,
    double? mrp,
    String? mainImageUrl,
    List? additionImages,
    String? description,
    List? features,
    List? keywords,
    String? department,
    String? type,
    Map? moreDetails,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (title == null || identical(title, this.title)) &&
        (publishedDate == null ||
            identical(publishedDate, this.publishedDate)) &&
        (reviews == null || identical(reviews, this.reviews)) &&
        (rating == null || identical(rating, this.rating)) &&
        (stock == null || identical(stock, this.stock)) &&
        (manufacturer == null || identical(manufacturer, this.manufacturer)) &&
        (price == null || identical(price, this.price)) &&
        (mrp == null || identical(mrp, this.mrp)) &&
        (mainImageUrl == null || identical(mainImageUrl, this.mainImageUrl)) &&
        (additionImages == null ||
            identical(additionImages, this.additionImages)) &&
        (description == null || identical(description, this.description)) &&
        (features == null || identical(features, this.features)) &&
        (keywords == null || identical(keywords, this.keywords)) &&
        (department == null || identical(department, this.department)) &&
        (type == null || identical(type, this.type)) &&
        (moreDetails == null || identical(moreDetails, this.moreDetails))) {
      return this;
    }

    return new Product(
      id: id ?? this.id,
      title: title ?? this.title,
      publishedDate: publishedDate ?? this.publishedDate,
      reviews: reviews ?? this.reviews,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      manufacturer: manufacturer ?? this.manufacturer,
      price: price ?? this.price,
      mrp: mrp ?? this.mrp,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      additionImages: additionImages ?? this.additionImages,
      description: description ?? this.description,
      features: features ?? this.features,
      keywords: keywords ?? this.keywords,
      department: department ?? this.department,
      type: type ?? this.type,
      moreDetails: moreDetails ?? this.moreDetails,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        publishedDate,
        reviews,
        rating,
        stock,
        manufacturer,
        price,
        mrp,
        mainImageUrl,
        additionImages,
        description,
        features,
        keywords,
        department,
        type,
        moreDetails
      ];
}
