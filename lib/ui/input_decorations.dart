import 'package:flutter/material.dart';
import '../../constants.dart';

class InputDecorations {
  static InputDecoration authInputDecoration(
      {required String hintText,
      required String labelText,
      IconData? prefixIcon}) {
    return InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: buttonColorDefault),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: buttonColorDefault, width: 2)),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: kTextLightColor),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: buttonColorDefault,
              )
            : null);
  }
}
