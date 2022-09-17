import 'package:flutter/material.dart';
import 'dart:math';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

Key generateKey() {
  const length = 8;
  final random = Random.secure();
  return ValueKey<String>(String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(random.nextInt(_chars.length)))));
}


class Product {
  final String image, title, description;
  final int price, id;
  Key? key;

  Product({
    required this.id,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    this.key
  });

  factory Product.withKey(Product product) => Product(
    id: product.id,
    image: product.image,
    title: product.title,
    price: product.price,
    description: product.description,
    key: generateKey()
  );
}