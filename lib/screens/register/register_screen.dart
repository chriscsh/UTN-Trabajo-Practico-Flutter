import 'package:flutter/material.dart';
import '../../providers/register_form_provider.dart';
import 'package:provider/provider.dart';

import '../../ui/input_decorations.dart';
import '../../ui/text_styles.dart';
import '../../widgets/widgets.dart';

import '../../../models/user.dart';
import '../../../constants.dart';
import '../../widgets/loading.dart';

class RegisterScreen extends StatelessWidget {

  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColorDefault,
        title: Text('Crear nueva cuenta', style: TextStyles.appBarText),
        elevation: 1,
        leading: BackButton(
          color: kTextColor,
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
      ),
      backgroundColor: backgroundColorLight,
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              children: [
                SizedBox(height: 10),
                _RegisterForm()
              ],
            ),
          ),
        ),
    );
  }
}

class _RegisterForm extends StatelessWidget {

  final double spaceBetweenFields = 30;

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(context);
    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            maxLength: 64,
            autocorrect: false,
            autofocus: true,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'john.doe@gmail.com',
                labelText: 'Correo electrónico',
                prefixIcon: Icons.person),
            onChanged: (value) {
              registerForm.email = value;
              registerForm.checkValidEmail();
            },
            validator: (value) {
              if (registerForm.sourceField != null && registerForm.sourceField != 'email') return null;
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = new RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'El valor ingresado no es un correo valido';
            },
          ),
          SizedBox(height: spaceBetweenFields),
          TextFormField(
            maxLength: 64,
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline),
            onChanged: (value) {
              registerForm.password = value;
              registerForm.checkValidPassword();
            },
            validator: (value) {
              if (registerForm.sourceField != null && registerForm.sourceField != 'password') return null;
              return (value != null && value.length >= 6)
                  ? null
                  : 'La contraseña debe de ser de al menos 6 caracteres';
            },
          ),
          SizedBox(height: spaceBetweenFields),
          TextFormField(
            maxLength: 64,
            autocorrect: false,
            keyboardType: TextInputType.name,
            decoration: InputDecorations.authInputDecoration(
                hintText: 'John Doe',
                labelText: 'Nombre',
                prefixIcon: Icons.person),
            onChanged: (value) {
              registerForm.name = value;
              registerForm.checkValidName();
            },
            validator: (value) {
              if (registerForm.sourceField != null && registerForm.sourceField != 'name') return null;
              return value!.isNotEmpty
                  ? null
                  : 'El nombre no debe estar vacio';
            },
          ),
          SizedBox(height: spaceBetweenFields),
          TextFormField(
            maxLength: 10,
            autocorrect: false,
            keyboardType: TextInputType.phone,
            decoration: InputDecorations.authInputDecoration(
                hintText: '1512341234',
                labelText: 'Telefono',
                prefixIcon: Icons.phone),
            onChanged: (value) {
              registerForm.phone = value;
              registerForm.checkValidPhone();
            },
            validator: (value) {
              if (registerForm.sourceField != null && registerForm.sourceField != 'phone') return null;
              return value!.isNotEmpty
                  ? null
                  : 'El telefono no debe estar vacio';
            },
          ),
          SizedBox(height: spaceBetweenFields),
          Row(
            children: [
              Expanded(
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: buttonColorDefault,
                  onPressed: (registerForm.isLoading || !registerForm.isValidForm)
                    ? null
                    : () async {
                        FocusScope.of(context).unfocus();
              
                        registerForm.isLoading = true;
              
                        final ds = userDataSource;
                        final userModel = User(
                          email: registerForm.email,
                          password: registerForm.password,
                          name: registerForm.name,
                          phone: registerForm.phone
                        );
                        final inserted = await ds.add(userModel);
                        registerForm.isLoading = false;
              
                        if (inserted == false) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Text('El email ya esta registrado')));
                        }
                        else {
                          Navigator.of(context).pop();
                          registerForm.formKey.currentState?.reset();
                        }
                      },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: registerForm.isLoading ?
                      LoadingIndicator(size: 25)
                      :
                      DefaultText('Registrar', color: buttonTextColorDefault)
                  )
                ),
              )
            ]
          ),
        ],
      ),
    );
  }
}
