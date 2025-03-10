import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:mvvm_arch/models/character.dart';
import 'package:mvvm_arch/models/product.dart';

import '../../models/cart.dart';
import '../errors/failure.dart';

class FakeStoreService {
  final dio = Dio();
  static const String _baseUrl = 'https://fakestoreapi.com';

  // fetching all products
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      final response = await dio.get('$_baseUrl/products');
      if (response.statusCode == 200) {
        final data = response.data as List;
        final products =
            data.map((product) => Product.fromJson(product)).toList();
        return Right(products);
      }
      return Left(ServerFailure(response.statusCode.toString()));
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(UnknownFailure(e.toString()));
    }
  }

  // fetching all categories
  Future<Either<Failure, List<String>>> getCategories() async {
    try {
      final response = await dio.get('$_baseUrl/products/categories');
      if (response.statusCode == 200) {
        final data = response.data as List;
        final List<String> categories = List.from(data);
        return Right(categories);
      }
      return Left(ServerFailure(response.statusCode.toString()));
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(UnknownFailure(e.toString()));
    }
  }

  // fetching all products
  Future<Either<Failure, List<Product>>> getProductsByCategory(
      String categoryType) async {
    try {
      final response =
          await dio.get('$_baseUrl/products/category/$categoryType');
      if (response.statusCode == 200) {
        final data = response.data as List;
        final products =
            data.map((product) => Product.fromJson(product)).toList();
        return Right(products);
      }
      return Left(ServerFailure(response.statusCode.toString()));
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(UnknownFailure(e.toString()));
    }
  }

  // fetching product by product id
  Future<Either<Failure, Product>> getProduct(String productId) async {
    try {
      final response = await dio.get('$_baseUrl/products/$productId');
      if (response.statusCode == 200) {
        final data = response.data;
        final product = Product.fromJson(data);
        return Right(product);
      }
      return Left(ServerFailure(response.statusCode.toString()));
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(UnknownFailure(e.toString()));
    }
  }

  // fetching cart items
  Future<Either<Failure, Cart>> getCartItems() async {
    try {
      final response = await dio.get('$_baseUrl/carts/1');
      if (response.statusCode == 200) {
        final data = response.data;
        final cart = Cart.fromJson(data);
        return Right(cart);
      }
      return Left(ServerFailure(response.statusCode.toString()));
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(UnknownFailure(e.toString()));
    }
  }

  // TODO: 2nd create a service/repository class for your http methods, see below implementation
  // fetching character by id
  Future<Either<Failure, Character>> getCharacterById() async {
    try {
      final response =
          await dio.get('https://thronesapi.com/api/v2/Characters/1');
      if (response.statusCode == 200) {
        final data = response.data;
        final character = Character.fromJson(data);
        return Right(character);
      }
      return Left(ServerFailure(response.statusCode.toString()));
    } catch (e) {
      if (e is DioException) {
        return Left(NetworkFailure(e.toString()));
      }
      return Left(UnknownFailure(e.toString()));
    }
  }
}
