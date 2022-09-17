import 'package:flutter/material.dart';


class RegisterFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  String _email    = '';
  bool _isValidEmail = false;
  
  get email => _email;
  set email(value) => _email = value;
  set isValidEmail( bool value ) {
    _isValidEmail = value;
    notifyListeners();
  }
  String _password    = '';
  bool _isValidPassword = false;
  
  get password => _password;
  set password(value) => _password = value;
  set isValidPassword( bool value ) {
    _isValidPassword = value;
    notifyListeners();
  }
  String _name    = '';
  bool _isValidName = false;
  
  get name => _name;
  set name(value) => _name = value;
  set isValidName( bool value ) {
    _isValidName = value;
    notifyListeners();
  }
  String _phone = '';
  bool _isValidPhone = false;
  
  get phone => _phone;
  set phone(value) => _phone = value;
  set isValidPhone( bool value ) {
    _isValidPhone = value;
    notifyListeners();
  }

  String? sourceField;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }

  bool get isValidForm => [_isValidEmail, _isValidPassword, _isValidName, _isValidPhone].every((element) => element);
  
  void checkValidEmail() {
    sourceField = 'email';
    isValidEmail = formKey.currentState?.validate() ?? false;
  }
  void checkValidPassword() {
    sourceField = 'password';
    isValidPassword = formKey.currentState?.validate() ?? false;
  }
  void checkValidName() {
    sourceField = 'name';
    isValidName = formKey.currentState?.validate() ?? false;
  }
  void checkValidPhone() {
    sourceField = 'phone';
    isValidPhone = formKey.currentState?.validate() ?? false;
  }
}