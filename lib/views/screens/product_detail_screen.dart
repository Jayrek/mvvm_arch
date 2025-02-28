import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/viewmodels/product/product_bloc.dart';
import 'package:mvvm_arch/views/widgets/outline_icon_button_widget.dart';

import '../../core/constants/constant_string.dart';
import '../../models/product.dart';
import '../widgets/cart_product_count_widget.dart';
import '../widgets/custom_elevated_button_widget.dart';
import '../widgets/product_item_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              ConstantString.navigationCartList,
            ),
            icon: const CartProductCountWidget(),
          )
        ],
        title: BlocSelector<ProductBloc, ProductState, String>(
          selector: (state) => state.product.category,
          builder: (context, category) => Text(
            category,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: BlocListener<ProductBloc, ProductState>(
        listenWhen: (previous, current) => previous.product != current.product,
        listener: (_, __) {
          _scrollToTop();
        },
        child: SingleChildScrollView(
          controller: _scrollController,
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: Hero(
                        tag: state.product.image,
                        child: CachedNetworkImage(
                          imageUrl: state.product.image,
                          fit: BoxFit.fill,
                          height: 450,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${ConstantString.dollarSign}${state.product.price}",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                      color: Colors.deepOrange,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                            ),
                            OutlineIconButton(
                              label: ConstantString.addToCart,
                              iconData: Icons.shopping_cart,
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            ConstantString.notYetAvailable)));
                              },
                            )
                          ],
                        ),
                        Text(
                          state.product.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                        Text(state.product.description),
                      ],
                    ),
                  ),
                  _buildRelatedProductWidget(state.product),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: CustomElevatedButtonWidget(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text(ConstantString.notYetAvailable)));
                        },
                        child: const Text(
                          ConstantString.buyNow,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildRelatedProductWidget(Product product) {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      final products = state.products;
      final List<Product> productsByCategory =
          products.where((prod) => prod.category == product.category).toList();

      return SizedBox(
        height: 120,
        child: ListView.builder(
            itemCount: productsByCategory.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              final prod = productsByCategory[index];

              return Padding(
                padding: const EdgeInsets.all(2),
                child: SizedBox(
                  width: 120,
                  child: ProductItemWidget(
                    product: prod,
                    imageHeight: 120,
                    maxLines: 1,
                    borderWidth: prod.id == product.id ? 2 : 0.1,
                    borderColor: prod.id == product.id
                        ? Colors.deepOrange
                        : Colors.black87,
                    onTap: () {
                      context.read<ProductBloc>().add(FetchProduct(
                            productId: prod.id.toString(),
                            isTapFromDetail: true,
                          ));
                    },
                  ),
                ),
              );
            })),
      );
    });
  }
}
