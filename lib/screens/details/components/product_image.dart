import 'package:flutter/material.dart';
import '../../../models/product.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    Key? key,
    required this.size,
    required this.product,
  }) : super(key: key);

  final Product product;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.white, width: double.infinity, height: size),
        Center(
          child: Container(
            height: size,
            child: Hero(
              tag: "${product.id}",
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          )
        ),
      ],
    );
  }
}