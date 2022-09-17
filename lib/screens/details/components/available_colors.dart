import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../models/product.dart';

class AvailableColors extends StatelessWidget {
  const AvailableColors({
    Key? key,
    required this.product
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Color"),
        Row(
          children: <Widget>[
            ColorDot(
              color: Color(0xFF356C95),
              isSelected: true,
            ),
            ColorDot(color: Color(0xFFF8C078)),
            ColorDot(color: Color(0xFFA29B9B)),
          ],
        ),
      ],
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const ColorDot({
    Key? key,
    required this.color,
    // by default isSelected is false
    this.isSelected = false,
    this.dotDiameter = 32.0
  }) : super(key: key);

  final double dotDiameter;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 8,
        right: 8,
      ),
      padding: EdgeInsets.all(2.5),
      height: dotDiameter,
      width: dotDiameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
