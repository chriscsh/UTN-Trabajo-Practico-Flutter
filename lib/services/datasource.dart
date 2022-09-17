import '../models/user.dart';
import '../models/product.dart';

export './local_database.dart';

abstract class UserDataSource {
  Future<bool> add(User user);
  Future<int?> exists(String key);
  Future<bool> update(User user);
  Future<User?> login(UserLogin user);
  Future<void> logout(User user);
}

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
  Future<List<Product>> getCart(User user);
  Future<void> emptyCart(User user);
  Future<void> deleteProduct(User user, Product product);
  Future<void> addProduct(User user, Product product);
  Future<List<Product>> searchProducts(String searchString);
}