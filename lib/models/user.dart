import 'product.dart';

class User {
  final String email;
  final String password;
  final String name;
  final String phone;
  final List<Product> cart;

  User({
    required this.email,
    required this.password,
    required this.name,
    required this.phone,
    this.cart = const []
  });
}

class UserLogin {
  final String email;
  final String password;

  UserLogin({
    required this.email,
    required this.password
  });
}