part of 'product_bloc.dart';

class ProductState extends Equatable {
  const ProductState({
    this.productFetchState = ProductFetchState.idle,
    this.productByIdState = ProductByIdState.idle,
    this.products = const [],
    this.errorMessage = '',
    this.categories = const [],
    this.product = Product.defautlValue,
    this.isTapFromDetail = false,
  });

  final ProductFetchState productFetchState;
  final ProductByIdState productByIdState;
  final List<Product> products;
  final String errorMessage;
  final List<Category> categories;
  final Product product;
  final bool isTapFromDetail;

  @override
  List<Object> get props => [
        productFetchState,
        productByIdState,
        products,
        errorMessage,
        categories,
        product,
        isTapFromDetail,
      ];

  ProductState copyWith({
    ProductFetchState? productFetchState,
    ProductByIdState? productByIdState,
    List<Product>? products,
    String? errorMessage,
    List<Category>? categories,
    Product? product,
    bool? isTapFromDetail,
  }) {
    return ProductState(
      productFetchState: productFetchState ?? this.productFetchState,
      productByIdState: productByIdState ?? this.productByIdState,
      products: products ?? this.products,
      errorMessage: errorMessage ?? this.errorMessage,
      categories: categories ?? this.categories,
      product: product ?? this.product,
      isTapFromDetail: isTapFromDetail ?? this.isTapFromDetail,
    );
  }
}
