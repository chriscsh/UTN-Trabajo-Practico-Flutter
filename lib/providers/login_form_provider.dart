import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/user.dart';


class LoginFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final ds = userDataSource;

  User? userLogged;

  Future<User?> login(UserLogin user) async {
    userLogged = await ds.login(user);
    return userLogged;
  }

  Future<void> logout() async {
    isLoading = true;
    await ds.logout(userLogged!);
    isLoading = false;
  }

  String _email    = '';
  bool _isValidEmail = false;

  get email => _email;
  set email(value) => _email = value;
  set isValidEmail( bool value ) {
    _isValidEmail = value;
    notifyListeners();
  }

  String _password = '';
  bool _isValidPassword = false;

  get password => _password;
  set password(value) => _password = value;
  set isValidPassword( bool value ) {
    _isValidPassword = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  String? sourceField;

  bool get isValidForm => [_isValidEmail, _isValidPassword].every((element) => element);
  
  void checkValidEmail() {
    sourceField = 'email';
    isValidEmail = formKey.currentState?.validate() ?? false;
  }

  void checkValidPassword() {
    sourceField = 'password';
    isValidPassword = formKey.currentState?.validate() ?? false;
  }
}