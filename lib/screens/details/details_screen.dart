import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../screens/details/components/body.dart';
import '../cart/cart_screen.dart';


class DetailsScreen extends StatelessWidget {

  static const routeName = '/details';

  const DetailsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductProvider>(context);
    return Scaffold(
      // each product have a color
      backgroundColor: backgroundColorLight,
      appBar: buildAppBar(context),
      body: Body(product: productViewModel.selectedProduct),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: appBarColorDefault,
      elevation: 0,
      leading: IconButton(
        icon: SvgPicture.asset(
          'assets/icons/back.svg',
          color: kTextColor,
        ),
        onPressed: () {
          final productProvider = Provider.of<ProductProvider>(context, listen: false);
          productProvider.getProducts();
          Navigator.of(context).pop();
        }
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/cart.svg", color: kTextColor),
          onPressed: () {
            final cart = Provider.of<CartProvider>(context, listen: false);
            cart.load();
            Navigator.of(context).pushNamed(CartScreen.routeName);
          },
        ),
        SizedBox(width: kDefaultPadding / 2)
      ],
    );
  }
}
