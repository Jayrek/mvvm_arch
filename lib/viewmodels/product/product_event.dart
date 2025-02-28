part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProductList extends ProductEvent {
  const FetchProductList();
}

class FetchProductByCategory extends ProductEvent {
  const FetchProductByCategory({required this.categoryType});

  final String categoryType;

  @override
  List<Object> get props => [categoryType];
}

class FetchCategoryList extends ProductEvent {
  const FetchCategoryList();
}

class FetchProduct extends ProductEvent {
  const FetchProduct({
    required this.productId,
    required this.isTapFromDetail,
  });
  final String productId;
  final bool isTapFromDetail;

  @override
  List<Object> get props => [productId, isTapFromDetail];
}
