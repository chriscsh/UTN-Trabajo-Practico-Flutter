import 'package:flutter/material.dart';
import '../../providers/login_form_provider.dart';
import '../../providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import '../../models/product.dart';
import '../../providers/search_provider.dart';
import '../../ui/text_styles.dart';
import '../../widgets/home_drawer.dart';
import '../../widgets/loading.dart';
import '../cart/cart_screen.dart';
import '../details/details_screen.dart';
import '../search/search_screen.dart';
import 'components/body.dart';
import '../../providers/cart_provider.dart';

class HomeScreen extends StatelessWidget {

  HomeScreen({ Key? key }) : super(key: key);

  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: buildAppBar(context),
      body: (product.isLoading) ?
        Center(child: LoadingIndicator(size: 40))
        :
        Body(product.products),
      drawer: HomeDrawer(),
    );
  }

  AppBar buildAppBar(BuildContext context) {

    return AppBar(
      backgroundColor: appBarColorDefault,
      elevation: 0,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.person_outline_outlined, color: Colors.grey),
            onPressed: () { Scaffold.of(context).openDrawer(); },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/search.svg",
            color: kTextColor,
          ),
          onPressed: () async {
            Navigator.of(context).pushNamed(SearchScreen.routeName);
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            "assets/icons/cart.svg",
            color: kTextColor,
          ),
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