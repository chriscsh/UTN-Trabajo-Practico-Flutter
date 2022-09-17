import 'package:flutter/material.dart';
import '../models/product.dart';
import '../constants.dart';


class ProductProvider extends ChangeNotifier {

  final ds = productDataSource;
  List<Product> _items = [];
  Product? _selectedProduct;

  List<Product> get products => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void getProducts({ String? searchString }) async {
    isLoading = true;
    if (searchString == null) {
      _items = await ds.getProducts();
    }
    else {
      _items = await ds.searchProducts(searchString);
    }
    isLoading = false;
  }

  void selectProduct(Product product) {
    _selectedProduct = product;
    notifyListeners();
  }

  Product get selectedProduct => _selectedProduct!;
}