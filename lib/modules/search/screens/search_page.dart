import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/products/widgets/product_list_card.dart';
import 'package:e_commerce/modules/search/blocs/search_cubit.dart';
import 'package:e_commerce/routes.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/functions/functions.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(AppStrings.search),
      ),
      body: BlocProvider(
        create: (_) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchState>(
          listener: (context, state) {
            if (state is SearchFailed) {
              context.showSnackBar(state.message);
            }
          },
          builder: (context, state) {
            final List<ProductListModel> products =
                state is SearchDone ? state.products : [];

            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      filled: true,
                      hintText: AppStrings.search,
                    ),
                    onChanged: (value) {
                      if (value.trim().isNotEmpty) {
                        context.read<SearchCubit>().searchForProducts(
                              value.trim(),
                            );
                      } else {
                        context.read<SearchCubit>().clearSearchResults(
                              value.trim(),
                            );
                      }
                    },
                  ),
                  Expanded(
                    child: state is SearchLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : products.isEmpty || state is SearchFailed
                            ? const MyErrorWidget(message: AppStrings.noResults)
                            : ListView.builder(
                                padding: const EdgeInsets.only(top: 16),
                                itemCount: products.length,
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  return RepositoryProvider.value(
                                    value: product,
                                    child: Builder(
                                      builder: (context) {
                                        return InkWell(
                                          onTap: () {
                                            context.navigate(
                                              Routes.singleProductRouteName,
                                              arguments: product,
                                            );
                                          },
                                          child: const ProductListCard(),
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
