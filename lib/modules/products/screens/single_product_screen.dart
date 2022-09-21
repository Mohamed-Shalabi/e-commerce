import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/modules/products/widgets/product_details_widget.dart';
import 'package:e_commerce/modules/products/widgets/product_images_slider.dart';
import 'package:e_commerce/modules/products/widgets/single_product_floating_action_buttons.dart';
import 'package:e_commerce/responsive/responsive_widget.dart';
import 'package:e_commerce/shared/components/my_error_widget.dart';
import 'package:e_commerce/shared/components/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is GetProductLoading || state is ProductInitial) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (state is GetProductFailed) {
          return MyErrorWidget(message: state.message);
        }

        final product = context.read<ProductCubit>().product;
        return Scaffold(
          appBar: AppBar(
            title: MyText(product.title),
          ),
          floatingActionButton: product.quantity == 0
              ? null
              : const SingleProductFloatingActionButtons(),
          body: ResponsiveWidget(
            mobileWidget: ListView(
              children: const [
                ProductImagesSlider(),
                Divider(thickness: 5, height: 48),
                ProductDetailsWidget(),
              ],
            ),
            tabletWidget: Row(
              children: const [
                Expanded(
                  child: ProductImagesSlider(),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: ProductDetailsWidget(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
