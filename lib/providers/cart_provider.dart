import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/product.dart';
import '../constants.dart';


class CartProvider extends ChangeNotifier {

  final ds = productDataSource;
  User? user;
  List<Product> _items = [];

  List<Product> get products => _items;
  int get totalAmount => _items.map((e) => e.price).reduce((value, element) => value + element);
  int get productCount => _items.length;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void reset() {
    _items = [];
    user = null;
  }

  void load() async {
    isLoading = true;
    _items = await ds.getCart(user!);
    isLoading = false;
  }

  Future<bool> add(Product product) async {
    isLoading = true;
    final productInstance = Product.withKey(product);
    await ds.addProduct(user!, productInstance);
    isLoading = false;
    return true;
  }

  void delete(Product product) async {
    isLoading = true;
    await ds.deleteProduct(user!, product);
    isLoading = false;
  }

  void empty() async {
    isLoading = true;
    await ds.emptyCart(user!);
    isLoading = false;
  }
}