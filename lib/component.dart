import 'package:flutter/material.dart';

// Custom TextStyle Components

TextStyle titleTextStyle({
  double fontSize = 24,
  Color color = Colors.black87,
  FontWeight fontWeight = FontWeight.bold,
  double letterSpacing = 1,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
    letterSpacing: letterSpacing,
  );
}

TextStyle subtitleTextStyle({
  double fontSize = 18,
  Color color = Colors.black54,
  FontWeight fontWeight = FontWeight.normal,
}) {
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: fontWeight,
  );
}
