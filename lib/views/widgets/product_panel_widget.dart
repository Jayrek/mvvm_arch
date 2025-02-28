import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/core/constants/constant_string.dart';

import '../../core/constants/enums/product_fetch_status.dart';
import '../../models/product.dart';
import '../../viewmodels/product/product_bloc.dart';
import 'product_item_widget.dart';

class ProductPanelWidget extends StatelessWidget {
  const ProductPanelWidget({
    required this.products,
    required this.productState,
    super.key,
  });

  final List<Product> products;
  final ProductState productState;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.productByIdState == ProductByIdState.success &&
            state.product.id != 0 &&
            !state.isTapFromDetail) {
          Navigator.pushNamed(context, ConstantString.navigationProductDetail);
        }
      },
      child: Stack(
        children: [
          if (products.isEmpty && productState.errorMessage.isNotEmpty)
            const Center(
              child: Text(ConstantString.noProducts),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  mainAxisExtent: 250,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ProductItemWidget(
                    product: product,
                    onTap: () {
                      context.read<ProductBloc>().add(FetchProduct(
                            productId: product.id.toString(),
                            isTapFromDetail: false,
                          ));
                    },
                  );
                }),
          ),
          if (productState.productFetchState == ProductFetchState.loading)
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.deepOrange,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
