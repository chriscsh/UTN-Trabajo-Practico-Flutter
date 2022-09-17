import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trabajo_practico/helpers/navigation_animation.dart';
import './screens/screens.dart';
import './constants.dart';
import 'providers/providers.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => LoginFormProvider()),
      ChangeNotifierProvider(create: (_) => RegisterFormProvider()),
      ChangeNotifierProvider(create: (_) => ProductProvider()),
      ChangeNotifierProvider(create: (_) => CartProvider()),
      ChangeNotifierProvider(create: (_) => SearchProvider()),
    ],
    child: MyApp()
  )
);
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trabajo Practico',
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        CartScreen.routeName: (_) => CartScreen(),
        SearchScreen.routeName: (_) => SearchScreen(),
        DetailsScreen.routeName: (_) => DetailsScreen()
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
    );
  }
}