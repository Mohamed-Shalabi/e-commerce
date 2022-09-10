import 'dart:math';

import 'package:e_commerce/modules/categories/blocs/categories_cubit.dart';
import 'package:e_commerce/responsive/responsive_Builder.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/navigate.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(AppStrings.categories),
      ),
      body: BlocConsumer<CategoriesCubit, CategoriesState>(
        listener: (BuildContext context, CategoriesState state) {
          if (state is CategoriesFetchError) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is CategoriesLoading || state is CategoriesInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CategoriesFetchError) {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: context.screenWidth * 0.5,
                    child: MyErrorWidget(message: state.message),
                  )
                ],
              ),
            );
          }

          if (state is CategoriesFetched) {
            final categories = state.categories;

            return ResponsiveWidget(
              mobileWidget: ListView.builder(
                itemCount: categories.length,
                padding: const EdgeInsets.only(top: 24),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      context.navigate(
                        Routes.productsRouteName,
                        arguments: category,
                      );
                    },
                    child: MyCard(
                      color: Colors.primaries[Random().nextInt(18)].shade200,
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
                },
              ),
              tabletWidget: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return InkWell(
                    onTap: () {
                      context.navigate(
                        Routes.productsRouteName,
                        arguments: category,
                      );
                    },
                    child: MyCard(
                      color: Colors.primaries[Random().nextInt(18)].shade200,
                      width: context.screenWidth * 0.3,
                      margin: const EdgeInsetsDirectional.fromSTEB(
                        24,
                        24,
                        0,
                        16,
                      ),
                      child: Center(
                        child: MyText(
                          category.name,
                          style: context.textTheme.titleLarge,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const MyErrorWidget(message: AppStrings.unknownError);
        },
      ),
    );
  }
}
