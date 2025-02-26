import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_arch/core/services/fake_store_service.dart';

import '../../core/constants/enums/product_fetch_status.dart';
import '../../models/category.dart';
import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FakeStoreService fakeStoreService;
  ProductBloc({required this.fakeStoreService}) : super(const ProductState()) {
    on<FetchProduct>(_onFetchProduct);
    on<FetchCategory>(_onFetchCategory);
    on<FetchProductByCategory>(_onFetchProductByCategory);
  }

  FutureOr<void> _onFetchProduct(
    FetchProduct event,
    Emitter<ProductState> emit,
  ) async {
    emit(state.copyWith(
      productFetchState: ProductFetchState.loading,
      errorMessage: '',
    ));
    final products = await fakeStoreService.getProducts();
    products.fold(
      (failure) {
        emit(
          state.copyWith(
            productFetchState: ProductFetchState.failed,
            products: [],
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        final updatedCategories = state.categories
            .map(
              (category) => category.copyWith(
                isSelected: category.categoryName == 'all',
              ),
            )
            .toList();
        emit(
          state.copyWith(
            productFetchState: ProductFetchState.success,
            products: data,
            errorMessage: '',
            categories: updatedCategories,
          ),
        );
      },
    );
  }

  // fetch categories
  FutureOr<void> _onFetchCategory(
      FetchCategory event, Emitter<ProductState> emit) async {
    final categories = await fakeStoreService.getCategories();
    categories.fold((failure) {
      debugPrint('exception: $failure');
    }, (data) {
      List<Category> categories = [];
      List<String> tempCategories = data;
      for (final category in tempCategories) {
        categories.add(Category(categoryName: category, isSelected: false));
      }
      categories.add(const Category(categoryName: 'all', isSelected: true));
      emit(state.copyWith(categories: categories));
    });
  }

  // fetch product by category type
  FutureOr<void> _onFetchProductByCategory(
      FetchProductByCategory event, Emitter<ProductState> emit) async {
    final updatedCategories = state.categories
        .map(
          (category) => category.copyWith(
            isSelected: category.categoryName == event.categoryType,
          ),
        )
        .toList();
    emit(state.copyWith(
      productFetchState: ProductFetchState.loading,
      errorMessage: '',
      products: state.products,
      categories: updatedCategories,
    ));
    debugPrint('categoryType: ${event.categoryType}');
    if (event.categoryType == 'all') {
      add(const FetchProduct());
    } else {
      final products =
          await fakeStoreService.getProductsByCategory(event.categoryType);
      products.fold(
        (failure) {
          emit(
            state.copyWith(
              productFetchState: ProductFetchState.failed,
              products: [],
              errorMessage: failure.message,
            ),
          );
        },
        (data) {
          emit(
            state.copyWith(
              productFetchState: ProductFetchState.success,
              products: data,
              errorMessage: '',
            ),
          );
        },
      );
    }
  }
}
