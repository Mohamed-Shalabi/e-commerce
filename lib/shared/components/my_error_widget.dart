import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({Key? key, required this.message}) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MyCard(
        margin: const EdgeInsets.all(32),
        color: context.colorScheme.error,
        padding: const EdgeInsets.all(24),
        child: MyText(
          message,
          style: context.textTheme.titleLarge?.copyWith(
            color: context.colorScheme.onError,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
