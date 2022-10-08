import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key,
    required this.child,
    this.width,
    this.height,
    this.color,
    this.constraints,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    this.borderRadius,
  }) : super(key: key);

  final Widget child;
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final BoxConstraints? constraints;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      constraints: constraints,
      margin: margin,
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: color ?? context.colorScheme.surface,
        borderRadius: BorderRadius.circular(borderRadius ?? 8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade500,
            blurRadius: 2.0,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
  }
}
