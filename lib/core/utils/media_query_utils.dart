import 'dart:math';

import 'package:flutter/material.dart';

extension MediaQueryUtils on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  double get screenWidth => mediaQuery.size.width;

  double get screenHeight => mediaQuery.size.height;

  double get smallerDimension => min(screenWidth, screenHeight);

  double get devicePixelRatio => mediaQuery.devicePixelRatio;

  bool get isPortrait => mediaQuery.orientation == Orientation.portrait;
}
