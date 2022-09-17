import 'package:flutter/material.dart';
import '../../../screens/details/components/available_colors.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';
import '../../../models/product.dart';

import '../../../providers/cart_provider.dart';
import 'add_to_cart.dart';
import 'price.dart';
import 'title.dart';
import 'description.dart';
import 'product_image.dart';

class Body extends StatelessWidget {
  final Product product;

  const Body({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double imageSize = size.height / 3;

    return Stack(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ProductImage(size: imageSize, product: product),
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      ProductTitle(product: product),
                      SizedBox(height: 8),
                      ProductPrice(product: product),
                      Divider(
                        thickness: 0.9,
                        height: 64,
                        color: Colors.grey.shade400
                      ),
                      ProductDescription(product: product),
                    ]
                  )
                ),
                SizedBox(height: 120)
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 32,
          left: size.width * 0.1 / 2,
          right: size.width * 0.1 / 2,
          child: Container(
            width: size.width * 0.9,
            height: 56,
            alignment: Alignment.center,
            child: AddToCart(product: product)
          ),
        )
      ]
    );
  }
}