import 'package:flutter/material.dart';
import 'dart:ui';

class CustomTheme {
  const CustomTheme();

  static const Color colorPage1 = Color(0xFFB3E5FC);
  static const Color colorPage2 = Color(0xFFFFCCBC);
  static const Color colorPage3 = Color(0xFFC8E6C9);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[colorPage1, colorPage2],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: <Color>[colorPage2, colorPage1],
    stops: <double>[1.0, 0.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient buttonGradient = LinearGradient(
    colors: <Color>[Color(0xFF42A5F5), Color(0xFF1E88E5)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: <Color>[
      Color(0xFFB3E5FC),
      Color(0xFFFFCCBC),
      Color(0xFFC8E6C9),
    ],
    stops: <double>[0.0, 0.5, 1.0],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class Images {
  const Images();
  static const String images1 = 'assets/images/image-1.png';
  static const String images2 = 'assets/images/image-2.png';
  static const String images3 = 'assets/images/image-3.png';
  static const String images4 = 'assets/images/image-4.png';
  static const String images5 = 'assets/images/image-5.png';
}
