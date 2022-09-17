import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_practico/dialog/confirmation.dart';

import '../constants.dart';
import '../providers/cart_provider.dart';
import '../providers/login_form_provider.dart';
import '../ui/text_styles.dart';
import 'loading.dart';

class HomeDrawer extends StatelessWidget {
  HomeDrawer({ Key? key }) : super(key: key);

  final transitionDuration = Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context){
    final cart = Provider.of<CartProvider>(context);
    final login = Provider.of<LoginFormProvider>(context);

    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            duration: transitionDuration,
            decoration: _coloredBackground(),
            child: Row(
              children: [
                Flexible(
                  child: DrawerText('Hola, ${login.userLogged!.name}')
                ),
                //Expanded(child: Container())
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: ColoredText('Logout', fontSize: 16),
            trailing: (!login.isLoading) ? null :
            LoadingIndicator(size: 35),
            onTap: (login.isLoading) ? null : () async {
              final res = await yesNoDialog(context, 'Desea desloguearse?');
              if (res) {
                await login.logout();
                Navigator.of(context).pop();
                await Future.delayed(transitionDuration);
                Navigator.of(context).pop();
                cart.reset();
              }
            },
          ),
        ],
      )
    );
  }

  BoxDecoration _coloredBackground() => BoxDecoration(
    gradient: LinearGradient(colors: [
      appBarColorContrast,
      appBarColorMedium
  ]));
}