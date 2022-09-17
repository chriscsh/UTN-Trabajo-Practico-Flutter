import 'package:flutter/material.dart';
import '../../constants.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _ColoredBox(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: Icon(
          Icons.person_pin,
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}

class _ColoredBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final boxHeight = size.height * 0.4;
    final boxWidth = size.width;

    return Container(
      width: double.infinity,
      height: boxHeight,
      decoration: _coloredBackground(),
      child: Stack(
        children: [
          Positioned(child: _Bubble()),
          Positioned(child: _Bubble(), top: boxHeight / 1.5, left: boxWidth / 1.5),
          Positioned(child: _Bubble(), top: boxHeight / 2, left: boxWidth / 6),
          Positioned(child: _Bubble(), top: boxHeight / 3, left: boxWidth / 8),
          Positioned(child: _Bubble(), top: boxHeight / 6, left: boxWidth / 3.5),
          Positioned(child: _Bubble(), top: boxHeight / 2.5, left: boxWidth / 1.15),
          Positioned(child: _Bubble(), top: boxHeight / 3.7, left: boxWidth / 1.2),
          Positioned(child: _Bubble(), top: boxHeight / 6.9, left: boxWidth / 1.5),
          Positioned(child: _Bubble(), top: boxHeight / 2.7, left: boxWidth / 2),
          Positioned(child: _Bubble(), top: boxHeight / 3.9, left: boxWidth / 2.7),
        ],
      ),
    );
  }

  BoxDecoration _coloredBackground() => BoxDecoration(
    gradient: LinearGradient(colors: [
      appBarColorContrast,
      appBarColorLight
  ]));
}

class _Bubble extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Color.fromRGBO(255, 255, 255, 0.15)),
    );
  }
}
