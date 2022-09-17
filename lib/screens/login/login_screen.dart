import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/login_form_provider.dart';
import '../../providers/product_provider.dart';
import '../../ui/text_styles.dart';
import '../../widgets/loading.dart';
import '../register/register_screen.dart';
import '../home/home_screen.dart';

import '../../ui/input_decorations.dart';
import '../../widgets/widgets.dart';

import '../../models/user.dart';
import '../../constants.dart';
import '../../providers/cart_provider.dart';

class LoginScreen extends StatelessWidget {

  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 250),
              CardContainer(
                  child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  SizedBox(height: 30),
                  _LoginForm()
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    final cart = Provider.of<CartProvider>(context);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.person),
              onChanged: (value) {
                loginForm.email = value;
                loginForm.checkValidEmail();
              },
              validator: (value) {
                if (loginForm.sourceField != null && loginForm.sourceField != 'email') return null;
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no es un correo valido';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecorations.authInputDecoration(
                  hintText: '*****',
                  labelText: 'Contraseña',
                  prefixIcon: Icons.lock_outline),
              onChanged: (value) {
                loginForm.password = value;
                loginForm.checkValidPassword();
              },
              validator: (value) {
                if (loginForm.sourceField != null && loginForm.sourceField != 'password') return null;
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: buttonColorDefault,
                child: Container(
                  height: 45,
                  width: 215,
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: (loginForm.isLoading) ?
                  LoadingIndicator(size: 25)
                  :
                  DefaultText(
                    'Ingresar',
                    color: buttonTextColorDefault
                  )
                ),
                onPressed: (loginForm.isLoading || !loginForm.isValidForm)
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      loginForm.isLoading = true;

                      final user = UserLogin(
                        email: loginForm.email,
                        password: loginForm.password
                      );
                      final userLogin = await loginForm.login(user);

                      if (userLogin != null) {
                        cart.user = userLogin;
                        final product = Provider.of<ProductProvider>(context, listen: false);
                        product.getProducts();
                        Navigator.of(context).pushNamed(HomeScreen.routeName);
                        loginForm.formKey.currentState?.reset();
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('Email no existente o contraseña erronea')));
                      }

                      loginForm.isLoading = false;
                    },
              )
            ),
            
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: buttonColorDefault,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 28, vertical: 15),
                  child: DefaultText(
                    'Crear una nueva cuenta',
                    color: buttonTextColorDefault,
                  )
                ),
                onPressed: (loginForm.isLoading) ? null : () {
                  Navigator.of(context).pushNamed(RegisterScreen.routeName);
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}
