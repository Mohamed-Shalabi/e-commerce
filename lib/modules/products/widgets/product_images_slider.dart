import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/modules/products/blocs/single_product/product_cubit.dart';
import 'package:e_commerce/shared/utils/media_query_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductImagesSlider extends StatelessWidget {
  const ProductImagesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<ProductCubit>();
    final product = viewModel.product;

    return CarouselSlider(
      options: CarouselOptions(
        padEnds: true,
        autoPlay: true,
        enlargeCenterPage: true,
        pageSnapping: true,
        autoPlayInterval: const Duration(seconds: 2),
      ),
      items: [
        for (final image in product.images)
          Image.asset(
            image,
            width: context.screenWidth,
            height: context.screenHeight * 0.33,
            fit: BoxFit.contain,
          ),
      ],
    );
  }
}
