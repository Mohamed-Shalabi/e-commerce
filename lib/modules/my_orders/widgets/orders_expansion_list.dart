import 'package:e_commerce/modules/cart/widgets/cart_product_list_tile.dart';
import 'package:e_commerce/modules/my_orders/blocs/my_orders_cubit.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrdersExpansionList extends StatelessWidget {
  const OrdersExpansionList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orders = context.read<MyOrdersCubit>().orders;

    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return ExpansionTile(
          title: MyText(order.formattedDate),
          childrenPadding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            for (final product in order.products) ...[
              RepositoryProvider.value(
                value: product,
                child: const CartProductListTile(isInOrdersScreen: true),
              ),
              const Divider(thickness: 3),
            ]
          ],
        );
      },
    );
  }
}
