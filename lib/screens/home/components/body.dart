import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/product_provider.dart';
import '../../details/details_screen.dart';
import 'item_card.dart';

class Body extends StatelessWidget {

  Body(this.products, {Key? key, this.popOnPress = false }) : super(key: key);

  final List<Product> products;
  final bool popOnPress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 4),
            child: GridView.builder(
              itemCount: products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                // mainAxisSpacing: kDefaultPadding,
                // crossAxisSpacing: kDefaultPadding,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) => ItemCard(
                product: products[index],
                press: () {
                  if (popOnPress) {
                    Navigator.pop(
                      context,
                      products[index]
                    );
                  }
                  else {
                    final productViewModel = Provider.of<ProductProvider>(context, listen: false);
                    productViewModel.selectProduct(products[index]);
                    Navigator.of(context).pushNamed(DetailsScreen.routeName);
                  }
                }
              ),
            ),
          ),
        ),
      ],
    );
  }
}
