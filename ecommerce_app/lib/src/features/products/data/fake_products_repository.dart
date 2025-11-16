import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/test_products.dart';
import '../domain/product.dart';

class FakeProductsRepository {
  final _products = kTestProducts;

  List<Product> getProducts() => _products;

  Product? getProduct(String id) =>
      _products.firstWhere((product) => product.id == id);

  Future<List<Product>> fetchProducts() async {
    await Future.delayed(const Duration(seconds: 2));
    // throw Exception('Failed to fetch products');
    return Future.value(_products);
  }

  Stream<List<Product>> watchProducts() async* {
    await Future.delayed(const Duration(seconds: 2));
    yield _products;
  }

  Stream<Product?> watchProduct(String id) => watchProducts()
      .map((products) => products.firstWhere((product) => product.id == id));
}

final productsRepositoryProvider =
    Provider<FakeProductsRepository>((ref) => FakeProductsRepository());

final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProducts();
});

final productsFutureProvider = FutureProvider<List<Product>>((ref) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProducts();
});

final productStreamProvider =
    StreamProvider.family<Product?, String>((ref, id) {
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
