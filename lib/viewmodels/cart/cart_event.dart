part of 'cart_bloc.dart';

class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class FetchCartProductList extends CartEvent {
  const FetchCartProductList();
}

class FetchCartProduct extends CartEvent {
  const FetchCartProduct();
}
