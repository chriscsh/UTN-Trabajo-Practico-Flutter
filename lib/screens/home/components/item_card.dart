import 'package:flutter/material.dart';
import '../../../models/product.dart';

import '../../../constants.dart';
import '../../../ui/text_styles.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final void Function() press;
  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  static const double borderRadius = 16;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 4, 4, 0),
        decoration: BoxDecoration(
          color: itemColor,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(4.0),
                child: Hero(
                  tag: "${product.id}",
                  child: Image.asset(product.image, fit: BoxFit.contain),
                ),
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: LightColoredText(
                      product.title,
                      textAlign: TextAlign.left,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8, bottom: 8),
              child: Row(
                children: [
                  DefaultText(
                    "\$ ${product.price}",
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.left,
                  ),
                  Expanded(child: Container())
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
