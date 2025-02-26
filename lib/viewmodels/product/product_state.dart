part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productFetchState = ProductFetchState.idle,
    this.products = const [],
    this.errorMessage = '',
    this.categories = const [],
  });

  final ProductFetchState productFetchState;
  final List<Product> products;
  final String errorMessage;
  final List<Category> categories;

  @override
  List<Object> get props => [
        productFetchState,
        products,
        errorMessage,
        categories,
      ];

  ProductState copyWith(
      {ProductFetchState? productFetchState,
      List<Product>? products,
      String? errorMessage,
      List<Category>? categories}) {
    return ProductState(
      productFetchState: productFetchState ?? this.productFetchState,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
    );
  }
}
