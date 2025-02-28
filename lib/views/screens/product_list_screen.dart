import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constants/enums/product_fetch_status.dart';
import '../../models/category.dart';
import '../../viewmodels/product/product_bloc.dart';
import '../widgets/cart_product_count_widget.dart';
import '../widgets/category_panel_widget.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/product_panel_widget.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'FakeStoreApp',
          style: Theme.of(context)
              .textTheme
              .displayLarge
              ?.copyWith(color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/cartList'),
            icon: const CartProductCountWidget(),
          )
        ],
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                List<Category> categories = state.categories;
                return CategoryPanelWidget(categories: categories);
              },
            ),
            BlocConsumer<ProductBloc, ProductState>(
              listener: (context, state) {
                if (state.productFetchState == ProductFetchState.failed &&
                    state.errorMessage.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMessage)));
                }
              },
              builder: (context, state) {
                final products = state.products;
                return ProductPanelWidget(
                  products: products,
                  productState: state,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
