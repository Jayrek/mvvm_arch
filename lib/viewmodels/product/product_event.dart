part of 'product_bloc.dart';

class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class FetchProduct extends ProductEvent {
  const FetchProduct();
}

class FetchProductByCategory extends ProductEvent {
  const FetchProductByCategory({required this.categoryType});

  final String categoryType;

  @override
  List<Object> get props => [categoryType];
}

class FetchCategory extends ProductEvent {
  const FetchCategory();
}
