class Cart {
  const Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
  });

  final int id;
  final int userId;
  final String date;
  final List<CartProduct> products;

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      id: json['id'],
      userId: json['userId'],
      date: json['date'],
      products: (json['products'] as List<dynamic>)
          .map((product) => CartProduct.fromJson(product))
          .toList(),
    );
  }

  @override
  String toString() {
    return ' Cart(id: $id, userId: $userId, date: $date, products: $products)';
  }

  static const defaultValue = Cart(
    id: 0,
    userId: 0,
    date: '0000-00-00T00:00:00.000Z',
    products: [],
  );
}

class CartProduct {
  const CartProduct({
    required this.productId,
    required this.quantity,
  });
  final int productId;
  final int quantity;

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      quantity: json['quantity'],
    );
  }

  @override
  String toString() {
    return 'CartProduct(productId: $productId, quantity: $quantity)';
  }
}
