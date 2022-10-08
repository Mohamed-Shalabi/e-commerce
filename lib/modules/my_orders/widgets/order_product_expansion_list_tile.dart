import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/my_orders/blocs/my_orders_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderProductExpansionListTile extends StatelessWidget {
  const OrderProductExpansionListTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productMapEntry = context.read<MapEntry<ProductListModel, int>>();
    final product = productMapEntry.key;
    final productCount = productMapEntry.value;

    return SizedBox(
      width: double.infinity,
      height: 88,
      child: Row(
        children: [
          Image.asset(
            product.mainImage,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
          const VerticalDivider(thickness: 3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        AppStrings.price,
                        style: context.textTheme.subtitle1,
                      ),
                      MyText(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: context.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        AppStrings.quantity,
                        style: context.textTheme.subtitle1,
                      ),
                      BlocBuilder<MyOrdersCubit, MyOrdersState>(
                        builder: (context, state) {
                          return MyText(
                            '$productCount',
                            style: context.textTheme.subtitle1,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyText(
                        AppStrings.total,
                        style: context.textTheme.subtitle1,
                      ),
                      MyText(
                        '\$${(product.price * productCount).toStringAsFixed(2)}',
                        style: context.textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
