import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Constant {
  static Color textOnDarkColor = Colors.white;
  static Color textOnLightColor = Colors.black;
  static TextStyle labelStyleOnDarkColor = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Constant.textOnDarkColor);
  static TextStyle labelStyleOnLightColor = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: Constant.textOnLightColor);
  static String dateToString(DateTime date) {
    final df = DateFormat('dd MMM yyyy');
    return df.format(date);
  }
}
