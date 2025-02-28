import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mvvm_arch/core/constants/constant_string.dart';

import '../../viewmodels/cart/cart_bloc.dart';
import '../../viewmodels/product/product_bloc.dart';
import '../widgets/custom_elevated_button_widget.dart';

class CartListScreen extends StatelessWidget {
  const CartListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>()
      ..add(const FetchCartProductList())
      ..add(const FetchCartProduct());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(ConstantString.reviewItemBeforeProceeding)));
            },
            child: Text(
              ConstantString.checkOut,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 15, color: Colors.white),
            ),
          )
        ],
        title: Text(
          ConstantString.cart,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 20, color: Colors.white),
        ),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {},
        builder: (context, state) {
          final cartProducts = state.cartProduct.products;
          final products = state.products;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView.separated(
                  itemCount: products.length,
                  itemBuilder: ((context, index) {
                    final cartProduct = cartProducts[index];
                    final product = products[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Hero(
                            tag: product.id,
                            child: CachedNetworkImage(
                              imageUrl: product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${ConstantString.dollarSign} ${product.price}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text('qty: ${cartProduct.quantity}'),
                          ],
                        ),
                        onTap: () {
                          context.read<ProductBloc>().add(FetchProduct(
                                productId: product.id.toString(),
                                isTapFromDetail: true,
                              ));
                        },
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 0,
                      indent: 20,
                      endIndent: 20,
                    );
                  },
                ),
              ),
              const Text(ConstantString.reviewItem),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: CustomElevatedButtonWidget(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(
                      ConstantString.shopMore,
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 70,
                color: Colors.deepOrange,
                child: BlocSelector<CartBloc, CartState, double>(
                  selector: (state) => state.totalPrice,
                  builder: (context, price) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const Text(ConstantString.totalPrice),
                          Text(
                            '${ConstantString.dollarSign} $price',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
