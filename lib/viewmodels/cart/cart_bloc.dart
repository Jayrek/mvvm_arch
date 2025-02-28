import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_arch/core/services/fake_store_service.dart';

import '../../models/cart.dart';
import '../../models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final FakeStoreService fakeStoreService;
  CartBloc({required this.fakeStoreService}) : super(const CartState()) {
    on<FetchCartProductList>(_onFetchCartProductList);
    on<FetchCartProduct>(_onFetchCartProduct);
  }

  FutureOr<void> _onFetchCartProductList(
      FetchCartProductList event, Emitter<CartState> emit) async {
    final response = await fakeStoreService.getCartItems();
    response.fold(
      (failure) {
        debugPrint('_onFetchCartProductList $failure');
      },
      (data) {
        emit(state.copyWith(cartProduct: data));
        // add(const FetchCartProduct());
      },
    );
  }

  FutureOr<void> _onFetchCartProduct(
      FetchCartProduct event, Emitter<CartState> emit) async {
    final List<CartProduct> cartProducts =
        List.from(state.cartProduct.products);
    final List<Product> products = [];
    double price = 0;
    for (int i = 0; i < cartProducts.length; i++) {
      final product = await fakeStoreService
          .getProduct(cartProducts[i].productId.toString());
      product.fold(
        (failure) {
          debugPrint('_onFetchCartProduct $failure');
        },
        (data) {
          products.add(data);
          debugPrint('products: $products');
          price += data.price * cartProducts[i].quantity;
        },
      );
    }
    emit(
      state.copyWith(
        products: products,
        totalPrice: price,
      ),
    );
  }
}
