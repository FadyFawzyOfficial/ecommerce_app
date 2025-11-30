import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/test_products.dart';
import '../../../utils/delay.dart';
import '../domain/product.dart';

class FakeProductsRepository {
  final bool addDelay;
  final _products = kTestProducts;

  const FakeProductsRepository({this.addDelay = true});

  List<Product> getProducts() => _products;

  static Product? _getProductOrNull(List<Product> products, String id) {
    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      return null;
    }
  }

  Product? getProduct(String id) {
    return _getProductOrNull(_products, id);
  }

  Future<List<Product>> fetchProducts() async {
    await delay(addDelay: addDelay);
    // throw Exception('Failed to fetch products');
    return Future.value(_products);
  }

  Stream<List<Product>> watchProducts() async* {
    await delay(addDelay: addDelay);
    yield _products;
  }

  Stream<Product?> watchProduct(String id) =>
      watchProducts().map((products) => _getProductOrNull(products, id));
}

final productsRepositoryProvider =
    Provider<FakeProductsRepository>((ref) => FakeProductsRepository());

final productsStreamProvider = StreamProvider.autoDispose<List<Product>>((ref) {
  // debugPrint('productsStreamProvider created');
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProducts();
});

final productsFutureProvider = FutureProvider.autoDispose<List<Product>>((ref) {
  // debugPrint('productsFutureProvider created');
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.fetchProducts();
});

final productStreamProvider =
    StreamProvider.autoDispose.family<Product?, String>((ref, id) {
  // debugPrint('productStreamProvider created with id: $id');
  // ref.onDispose(() => debugPrint('productStreamProvider disposed'));
  // final keepAliveLink = ref.keepAlive();
  // Timer(const Duration(seconds: 5), () => keepAliveLink.close());
  final productsRepository = ref.watch(productsRepositoryProvider);
  return productsRepository.watchProduct(id);
});
