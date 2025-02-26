import 'package:flutter/material.dart';

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
    return Stack(
      children: [
        if (products.isEmpty && productState.errorMessage.isNotEmpty)
          const Center(
            child: Text('No products available!'),
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
                    debugPrint('product: $product');
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
    );
  }
}
