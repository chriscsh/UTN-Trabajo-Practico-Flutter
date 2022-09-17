import 'package:flutter/material.dart';
import '../constants.dart';

class TextStyles {
  static const appBarText = TextStyle(
    color: kTextColor,
  );
  static const bodyText = TextStyle(
    color: kTextColor
  );
  static const bodyTextLight = TextStyle(
    color: kTextLightColor
  );
}

class DefaultText extends Text {
  DefaultText(String data, {
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight
  }) : super(
    data,
    textAlign: textAlign,
    style: TextStyle(fontSize: fontSize, color: color, fontWeight: fontWeight)
  );
}

class ColoredText extends Text {
  ColoredText(String data, {
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight
  }) : super(
    data,
    textAlign: textAlign,
    style: TextStyles.bodyText.copyWith(fontSize: fontSize, color: color, fontWeight: fontWeight)
  );
}

class LightColoredText extends Text {
  LightColoredText(String data, {
    double? fontSize,
    Color? color,
    TextAlign? textAlign,
    FontWeight? fontWeight
  }) : super(
    data,
    textAlign: textAlign,
    style: TextStyles.bodyTextLight.copyWith(fontSize: fontSize, color: color, fontWeight: fontWeight)
  );
}

class CheckoutText extends Text {
  CheckoutText(String data, {
    double? fontSize,
    Color? color
  }) : super(
    data,
    style: TextStyle(fontSize: fontSize, color: color)
  );
}

class DrawerText extends Text {
  DrawerText(String data, {
    double fontSize = 32,
    Color color = Colors.white,
    TextOverflow overflow = TextOverflow.visible
  }) : super(
    data,
    overflow: overflow,
    style: TextStyle(fontSize: fontSize, color: color)
  );
}