import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCircularIcon extends StatelessWidget {
  const MyCircularIcon(
      {Key? key, required this.radius, this.asset, this.iconData})
      : super(key: key);

  final double radius;
  final String? asset;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    assert(
      asset != null || iconData != null,
      'Either asset or iconData must not be null',
    );
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        color: context.colorScheme.secondary,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: asset == null
          ? Icon(
              iconData,
              color: context.colorScheme.onSecondary,
              size: radius * 2 - 8,
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(asset!),
            ),
    );
  }
}
