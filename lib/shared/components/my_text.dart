import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyText extends StatelessWidget {
  const MyText(
    this.text, {
    Key? key,
    this.textStyle,
    this.isTranslated = true,
    this.textAlign = TextAlign.start,
    this.overflow,
    this.maxLines,
  }) : super(key: key);

  final String text;
  final TextStyle? textStyle;
  final bool isTranslated;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      isTranslated ? text.tr() : text,
      style: textStyle,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
    );
  }
}
