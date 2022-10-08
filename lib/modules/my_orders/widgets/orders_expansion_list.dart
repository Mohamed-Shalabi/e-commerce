import 'package:e_commerce/modules/my_orders/blocs/my_orders_cubit.dart';
import 'package:e_commerce/modules/my_orders/widgets/order_product_expansion_list_tile.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/styles/app_themes.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersExpansionList extends StatelessWidget {
  const OrdersExpansionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = context.read<MyOrdersCubit>().orders;

    if (orders.isEmpty) {
      return const MyErrorWidget(message: AppStrings.noOrders);
    }

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ExpansionTile(
          title: MyText(order.formattedDate),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            for (final productMapEntry in order.products.entries) ...[
              RepositoryProvider.value(
                value: productMapEntry,
                child: const OrderProductExpansionListTile(),
              ),
            ],
            const Divider(thickness: 3),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(
                    AppStrings.total,
                    style: context.textTheme.subtitle1,
                  ),
                  MyText(
                    '\$${order.total}',
                    style: context.textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
