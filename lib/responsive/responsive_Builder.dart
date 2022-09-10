import 'package:e_commerce/responsive/constants.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    Key? key,
    required this.mobileWidget,
    this.tabletWidget,
  }) : super(key: key);

  final Widget mobileWidget;
  final Widget? tabletWidget;

  @override
  Widget build(BuildContext context) {
    if (tabletWidget == null) {
      return mobileWidget;
    }

    if (context.screenWidth < ScreensSizes.mobileMaxWidth) {
      return mobileWidget;
    } else {
      return tabletWidget!;
    }
  }
}
