import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
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
          children: [
            Text(product.title,
              textAlign: TextAlign.left,
              style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(
                  color: kTextColor
                ),
            ),
          ],
        ),
      ],
    );
  }
}