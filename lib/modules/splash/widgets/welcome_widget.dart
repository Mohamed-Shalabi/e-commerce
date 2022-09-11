import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: context.colorScheme.primary,
      radius: context.smallerDimension / 2 - 16,
      child: CircleAvatar(
        backgroundColor: context.colorScheme.surface,
        radius: context.smallerDimension / 2 - 42,
        child: CircleAvatar(
          backgroundColor: context.colorScheme.secondary,
          radius: context.smallerDimension / 2 - 56,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyText(
              'Welcome to Market App!',
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge?.copyWith(
                color: context.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
