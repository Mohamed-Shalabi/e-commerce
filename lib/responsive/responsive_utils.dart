import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';

extension ResponsiveUtils on BuildContext {
  bool get isMobileScreen => screenWidth < 500;
}