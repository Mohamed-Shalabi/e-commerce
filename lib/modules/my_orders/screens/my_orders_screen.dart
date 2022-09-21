import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/modules/cart/widgets/cart_product_list_tile.dart';
import 'package:e_commerce/modules/my_orders/blocs/my_orders_cubit.dart';
import 'package:e_commerce/modules/my_orders/widgets/orders_expansion_list.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/shared/components/my_card.dart';
import 'package:e_commerce/shared/components/my_divider.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:e_commerce/shared/components/show_snack_bar.dart';
import 'package:e_commerce/shared/utils/app_strings.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(AppStrings.myOrders),
      ),
      body: BlocConsumer<MyOrdersCubit, MyOrdersState>(
        listener: (context, state) {
          if (state is MyOrdersFetchFailed) {
            context.showSnackBar(state.message);
          }
        },
        builder: (context, state) {
          if (state is MyOrdersFetchLoading || state is MyOrdersInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is MyOrdersFetchFailed) {
            return MyErrorWidget(message: state.message);
          }

          return const ResponsiveWidget(
            mobileWidget: MyCard(
              margin: EdgeInsets.all(16),
              child: OrdersExpansionList(),
            ),
            tabletWidget: Center(
              child: MyCard(
                width: 480,
                margin: EdgeInsets.all(16),
                child: OrdersExpansionList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
