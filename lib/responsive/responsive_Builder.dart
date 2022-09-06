import 'package:e_commerce/responsive/constants.dart';
import 'package:flutter/material.dart';

class ResponsiveBuilder extends StatelessWidget {
  const ResponsiveBuilder(
      {Key? key, required this.mobileScreen, this.tabletScreen})
      : super(key: key);

  final Widget mobileScreen;
  final Widget? tabletScreen;

  @override
  Widget build(BuildContext context) {
    if (tabletScreen == null) {
      return mobileScreen;
    }

    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        if (constraints.maxWidth < ScreensSizes.mobileMaxWidth) {
          return mobileScreen;
        } else {
          return tabletScreen!;
        }
      },
    );
  }
}
