import 'package:e_commerce/modules/main_layout/widgets/mobile_main_layout_body.dart';
import 'package:e_commerce/modules/main_layout/widgets/tablet_main_layout_body.dart';
import 'package:e_commerce/responsive/responsive_Builder.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ResponsiveWidget(
      mobileWidget: MobileMainLayoutBody(),
      tabletWidget: TabletMainLayoutBody(),
    );
  }
}
