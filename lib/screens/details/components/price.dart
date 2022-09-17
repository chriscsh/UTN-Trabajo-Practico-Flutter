import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';
import '../../../ui/text_styles.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    Key? key,
    required this.product
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text("\$ ${product.price}",
                style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(
                    color: kTextColor,
                    fontWeight: FontWeight.bold
                  ),
              ),
            )
          ],
        ),
        Expanded(child: Container())
      ],
    );
  }
}