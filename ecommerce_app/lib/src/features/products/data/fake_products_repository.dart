import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';

class FakeProductsRepository {
  final _products = kTestProducts;

  List<Product> getProducts() => _products;

  Product? getProduct(String id) =>
      _products.firstWhere((product) => product.id == id);

  Future<List<Product>> fetchProducts() async => Future.value(_products);

  Stream<List<Product>> watchProducts() => Stream.value(_products);

  Stream<Product?> watchProduct(String id) => watchProducts()
      .map((products) => products.firstWhere((product) => product.id == id));
}

final productsRepositoryProvider =
    Provider<FakeProductsRepository>((ref) => FakeProductsRepository());
