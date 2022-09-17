import 'package:flutter/material.dart';
import '../models/product.dart';
import '../constants.dart';


class SearchProvider extends ChangeNotifier {

  final ds = productDataSource;
  List<Product> _items = [];

  List<Product> get products => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void searchProducts(String searchString) async {
    isLoading = true;
    _items = await ds.searchProducts(searchString);
    isLoading = false;
  }
}