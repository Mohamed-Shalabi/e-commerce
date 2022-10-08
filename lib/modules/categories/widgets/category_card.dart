import 'dart:math';

import 'package:e_commerce/core/components/my_card.dart';
import 'package:e_commerce/core/components/my_text.dart';
import 'package:e_commerce/core/functions/functions.dart';
import 'package:e_commerce/core/styles/app_themes.dart';
import 'package:e_commerce/modules/categories/categories/category_model.dart';
import 'package:e_commerce/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final category = context.read<CategoryModel>();
    final isLight = context.watch<AppThemesCubit>().isLight;
    final baseColor = Colors.primaries[Random().nextInt(18)];
    return InkWell(
      onTap: () {
        context.navigate(
          Routes.productsRouteName,
          arguments: category,
        );
      },
      child: MyCard(
        color: isLight ? baseColor.shade200 : baseColor.shade900,
        height: 48,
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
        child: Center(
          child: MyText(
            category.name,
            style: context.textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
