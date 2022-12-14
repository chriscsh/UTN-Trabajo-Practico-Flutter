import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key, required this.size}) : super(key: key);

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(dimension: size, child: CircularProgressIndicator());
  }
}