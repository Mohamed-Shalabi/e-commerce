import 'package:e_commerce/modules/categories/blocs/categories_cubit.dart';
import 'package:e_commerce/modules/categories/widgets/category_card.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
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
            return MyErrorWidget(message: state.message);
          }

          final categories = context.read<CategoriesCubit>().categories;

          return ResponsiveWidget(
            mobileWidget: ListView.builder(
              itemCount: categories.length,
              padding: const EdgeInsets.only(top: 24),
              itemBuilder: (context, index) {
                final category = categories[index];
                return RepositoryProvider.value(
                  value: category,
                  child: const CategoryCard(),
                );
              },
            ),
            tabletWidget: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.screenHeight > 500 ? 3 : 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 0, 16),
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = categories[index];
                return RepositoryProvider.value(
                  value: category,
                  child: const CategoryCard(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
