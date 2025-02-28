part of 'cart_bloc.dart';

class CartState extends Equatable {
  const CartState({
    this.cartProduct = Cart.defaultValue,
    this.products = const [],
    this.totalPrice = 0,
  });

  final Cart cartProduct;
  final List<Product> products;
  final double totalPrice;

  @override
  List<Object> get props => [
        cartProduct,
        products,
        totalPrice,
      ];

  CartState copyWith({
    Cart? cartProduct,
    List<Product>? products,
    double? totalPrice,
  }) {
    return CartState(
      cartProduct: cartProduct ?? this.cartProduct,
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
