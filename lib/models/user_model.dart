import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String phone;
  final List address;
  final List orderedProducts;
  final List likedProducts;
  final List cart;
  final int age;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.phone,
      required this.address,
      required this.orderedProducts,
      required this.likedProducts,
      required this.cart,
      required this.age});

  static User userEmpty = User(
      id: '',
      username: '',
      email: '',
      phone: '',
      address: [],
      age: -1,
      orderedProducts: [],
      cart: [],
      likedProducts: []);

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'phone': phone,
      'address': address,
      'orderedProducts': orderedProducts,
      'likedProducts': likedProducts,
      'cart': cart,
      'age': age,
    };
  }

  factory User.fromDocument(DocumentSnapshot doc) {
    final data = doc.data();
    return User(
      id: doc.id,
      username: data!['username'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? [],
      orderedProducts: data['orderedProducts'] ?? [],
      likedProducts: data['likedProducts'] ?? [],
      cart: data['cart'] ?? [],
      age: data['age'] ?? -1,
    );
  }

  User copyWith({
    String? id,
    String? username,
    String? email,
    String? phone,
    List? address,
    List? orderedProducts,
    List? likedProducts,
    List? cart,
    int? age,
  }) {
    if ((id == null || identical(id, this.id)) &&
        (username == null || identical(username, this.username)) &&
        (email == null || identical(email, this.email)) &&
        (phone == null || identical(phone, this.phone)) &&
        (address == null || identical(address, this.address)) &&
        (orderedProducts == null ||
            identical(orderedProducts, this.orderedProducts)) &&
        (likedProducts == null ||
            identical(likedProducts, this.likedProducts)) &&
        (cart == null || identical(cart, this.cart)) &&
        (age == null || identical(age, this.age))) {
      return this;
    }

    return new User(
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      orderedProducts: orderedProducts ?? this.orderedProducts,
      likedProducts: likedProducts ?? this.likedProducts,
      cart: cart ?? this.cart,
      age: age ?? this.age,
    );
  }

  @override
  List<Object> get props => [
        id,
        username,
        email,
        phone,
        address,
        orderedProducts,
        likedProducts,
        cart,
        age
      ];
}
