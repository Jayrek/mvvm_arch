import 'rating.dart';

class Product {
  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    required this.rating,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final String category;
  final String image;
  final Rating rating;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      image: json['image'],
      rating: Rating.fromJson(json['rating']),
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, title: $title, description: $description, price: $price, category: $category, image: $image, rating: $rating)';
  }

  // defining static default value for Product
  static const Product defautlValue = Product(
    id: 0,
    title: '',
    description: '',
    price: 0.0,
    category: '',
    image: '',
    rating: Rating(
      rate: 0,
      count: 1,
    ),
  );
}
