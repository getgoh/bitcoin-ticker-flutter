import 'package:flutter/material.dart';

const kAppTextTheme = TextTheme(
  title: TextStyle(
    fontFamily: 'OpenSans',
  ),
  body1: TextStyle(
    fontFamily: 'OpenSans',
  ),
  body2: TextStyle(
    fontFamily: 'OpenSans',
  ),
);

final kGradientBoxDecoration = BoxDecoration(
  gradient: RadialGradient(
    radius: 1.5,
    center: Alignment.topLeft,
    colors: [
      Colors.grey.shade600,
      Colors.grey.shade700,
      Colors.grey.shade800,
    ],
  ),
);
