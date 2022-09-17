import 'datasource.dart';
import '../models/user.dart';
import '../models/product.dart';

class LocalUserDataSource implements UserDataSource {
  final List<User> _users;
  static const globalDelay = 1;

  static final LocalUserDataSource _singleton = LocalUserDataSource._internal();

  factory LocalUserDataSource() {
    return _singleton;
  }

  LocalUserDataSource._internal() : _users = [
    User(email: 'chris@demo.com', password: 'password', name: 'Chris', phone: '123')
  ];

  @override
  Future<bool> add(User user) async {
    if (await exists(user.email) != null) {
      return false;
    }
    _users.add(user);
    return true;
  }

  @override
  Future<int?> exists(String key) async {
    await Future.delayed(Duration(seconds: globalDelay));

    for (var i = 0; i < _users.length; i++) {
      if (_users[i].email == key) {
        return i;
      }
    }
    return null;
  }

  @override
  Future<bool> update(User user) async {
    final index = await exists(user.email);
    if (index == null) {
      return false;
    }
    _users[index] = user;
    return true;
  }

  @override
  Future<User?> login(UserLogin user) async {
    await Future.delayed(Duration(seconds: globalDelay));

    for (var i = 0; i < _users.length; i++) {
      if (_users[i].email == user.email && _users[i].password == user.password) {
        return _users[i];
      }
    }
    return null;
  }

  @override
  Future<void> logout(User user) async {
    await Future.delayed(Duration(seconds: globalDelay));
  }
}


class LocalProductDataSource implements ProductDataSource {
  final Map<String, List<Product>> _carts;
  List<Product> _products;
  static const globalDelay = 1;

  static final LocalProductDataSource _singleton = LocalProductDataSource._internal();

  factory LocalProductDataSource() {
    return _singleton;
  }

  LocalProductDataSource._internal() : _products = [], _carts = {};

  @override
  Future<List<Product>> getCart(User user) async {
    await Future.delayed(Duration(seconds: globalDelay));

    final key = user.email;
    if (_carts.containsKey(key)) {
      return _carts[key]!;
    }
    return [];
  }

  @override
  Future<bool> addProduct(User user, Product product) async {
    await Future.delayed(Duration(seconds: globalDelay));

    final key = user.email;
    if (_carts.containsKey(key)) {
      _carts[key]!.add(product);
    }
    else {
      _carts[key] = [ product ];
    }
    return true;
  }
  
  @override
  Future<void> deleteProduct(User user, Product product) async {
    await Future.delayed(Duration(seconds: globalDelay));

    final key = user.email;
    if (_carts.containsKey(key)) {
      for (var i = 0; i < _carts[key]!.length; i++) {
        if (_carts[key]![i].key == product.key) {
          _carts[key]!.removeAt(i);
          break;
        }
      }
    }
  }
  
  @override
  Future<void> emptyCart(User user) async {
    await Future.delayed(Duration(seconds: globalDelay));

    final key = user.email;
    if (_carts.containsKey(key)) {
      _carts[key]!.clear();
    }
  }
  
  @override
  Future<List<Product>> searchProducts(String searchString) async {
    final fSearchPattern = RegExp.escape(searchString).split(' ').join('.*');
    RegExp regExp = new RegExp('.*$fSearchPattern.*', caseSensitive: false);
    return (await getProducts()).where((product) => regExp.hasMatch(product.title)).toList();
  }

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(Duration(seconds: globalDelay));
    
    if (_products.isEmpty) {
      loadProducts();
    }
    return _products;
  }

  void loadProducts() {
    const dummyText = "2022 Apple MacBook Pro Laptop with M2 chip\n13-inch Retina Display\n8GB RAM\n256GB ​​​​​​​SSD ​​​​​​​Storage\nTouch Bar\nBacklit Keyboard\nFaceTime HD Camera.\nWorks with iPhone and iPad\nSpace Gray\n2022 Apple MacBook Pro Laptop with M2 chip\n13-inch Retina Display\n8GB RAM\n256GB ​​​​​​​SSD ​​​​​​​Storage\nTouch Bar\nBacklit Keyboard\nFaceTime HD Camera.\nWorks with iPhone and iPad\nSpace Gray";
    _products = [
      Product(
        id: 1,
        title: "Apple MacBook Pro M1",
        price: 1250,
        description: dummyText,
        image: "assets/images/apple/macbook_pro_m1.jpg"
      ),
      Product(
        id: 2,
        title: "Apple MacBook Pro M2",
        price: 1300,
        description: dummyText,
        image: "assets/images/apple/macbook_pro_m2.jpg"
      ),
      Product(
        id: 3,
        title: "Apple MacBook Pro M1 Pro",
        price: 1400,
        description: dummyText,
        image: "assets/images/apple/macbook_pro_m1_max.jpg"
      ),
      Product(
        id: 4,
        title: "Apple MacBook Pro M1 Max",
        price: 1500,
        description: dummyText,
        image: "assets/images/apple/macbook_pro_m1_max.jpg"
      ),
      Product(
        id: 5,
        title: "Apple MacBook Air M1",
        price: 800,
        description: dummyText,
        image: "assets/images/apple/macbook_air_m1.jpg"
      ),
      Product(
        id: 6,
        title: "Apple MacBook Air M2",
        price: 1250,
        description: dummyText,
        image: "assets/images/apple/macbook_air_m2.jpg"
      ),
      Product(
        id: 7,
        title: "Apple iPad 10.2",
        price: 950,
        description: dummyText,
        image: "assets/images/apple/ipad.jpg"
      ),
      Product(
        id: 8,
        title: "Apple iPad Air 10.9",
        price: 800,
        description: dummyText,
        image: "assets/images/apple/ipad.jpg"
      ),
      Product(
        id: 9,
        title: "Apple iPad Pro 12.9",
        price: 1250,
        description: dummyText,
        image: "assets/images/apple/ipad_pro.jpg"
      ),
      Product(
        id: 10,
        title: "Apple iPad Mini 8.3",
        price: 800,
        description: dummyText,
        image: "assets/images/apple/ipad_mini.jpg"
      ),
    ];
  }
}