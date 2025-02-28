import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/cart.dart';
import '../../viewmodels/cart/cart_bloc.dart';

class CartProductCountWidget extends StatelessWidget {
  const CartProductCountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartBloc, CartState, Cart>(
      selector: (state) => state.cartProduct,
      builder: (context, cartProduct) {
        final count = cartProduct.products.length;
        return Stack(
          clipBehavior: Clip.none,
          children: [
            const Icon(
              Icons.shopping_cart,
              color: Colors.white,
              size: 30,
            ),
            count == 0
                ? const SizedBox()
                : Positioned(
                    right: -2,
                    top: -8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.shade900,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
