import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mvvm_arch/core/services/fake_store_service.dart';
import 'package:mvvm_arch/models/character.dart';

import '../../core/constants/enums/product_fetch_status.dart';
import '../../models/category.dart';
import '../../models/product.dart';

part 'product_event.dart';
part 'product_state.dart';

// TODO: 3rd create a bloc class for your business logics
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final FakeStoreService fakeStoreService;
  ProductBloc({required this.fakeStoreService}) : super(const ProductState()) {
    on<FetchProductList>(_onFetchProductList);
    on<FetchCategoryList>(_onFetchCategoryList);
    on<FetchProductByCategory>(_onFetchProductByCategory);
    on<FetchProduct>(_onFetchProduct);
    on<FetchCharacterById>(_onFetchCharacterById);
  }

  FutureOr<void> _onFetchProductList(
    FetchProductList event,
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
  FutureOr<void> _onFetchCategoryList(
      FetchCategoryList event, Emitter<ProductState> emit) async {
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
      product: Product.defautlValue,
    ));
    debugPrint('categoryType: ${event.categoryType}');
    if (event.categoryType == 'all') {
      add(const FetchProductList());
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

  FutureOr<void> _onFetchProduct(
      FetchProduct event, Emitter<ProductState> emit) async {
    emit(state.copyWith(
      productByIdState: ProductByIdState.loading,
      errorMessage: '',
      isTapFromDetail: event.isTapFromDetail,
    ));
    final product = await fakeStoreService.getProduct(event.productId);
    product.fold(
      (failure) {
        emit(
          state.copyWith(
            productByIdState: ProductByIdState.failed,
            errorMessage: failure.message,
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            productByIdState: ProductByIdState.success,
            product: data,
            errorMessage: '',
          ),
        );
      },
    );
  }

// TODO: 4rd invoke the getCharacterByID from the reposiory class,
// and handle the response accordingly from the repository (left, right),
// check the state and event
  FutureOr<void> _onFetchCharacterById(
      FetchCharacterById event, Emitter<ProductState> emit) async {
    final character = await fakeStoreService.getCharacterById();
    character.fold(
      (failure) {
        // emitting the left or exceptions encountered
        debugPrint('failure: $failure');
      },
      (data) {
        debugPrint('data: $data');
        // emitting the right or expected data
        emit(
          state.copyWith(
            character: data,
          ),
        );
      },
    );
  }
}
