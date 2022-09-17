import 'package:flutter/material.dart';
import 'services/datasource.dart';

// General Config
const kTextColor = Color(0xFF535353);
const kTextLightColor = Color(0xFFACACAC);

const kDefaultPadding = 4.0;

// Body Config
final itemColor = Colors.white;
final backgroundColor = Colors.grey.shade100;
final backgroundColorLight = Colors.white;

// Buttons Config
final buttonColorDefault = Colors.lightBlue.shade300;
final buttonTextColorDefault = Colors.white;

// AppBar Config
final appBarColorDefault = Colors.white;
final appBarColorLight = Colors.lightBlue.shade100;
final appBarColorMedium = Colors.lightBlue.shade200;
final appBarColorContrast = Colors.lightBlue.shade400;

// Data Sources Config
final userDataSource = LocalUserDataSource();
final productDataSource = LocalProductDataSource();