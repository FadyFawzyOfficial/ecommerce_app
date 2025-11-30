import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  FakeProductsRepository buildFakeProductsRepository() =>
      FakeProductsRepository(addDelay: false);

  group('FakeProductsRepository', () {
    test('getProducts() returns global list of products', () {
      final fakeProductsRepository = buildFakeProductsRepository();
      final products = fakeProductsRepository.getProducts();
      expect(products, kTestProducts);
    });

    test('getProduct(1) returns the first product ', () {
      final fakeProductsRepository = buildFakeProductsRepository();
      final product = fakeProductsRepository.getProduct('1');
      expect(product, kTestProducts.first);
    });

    test('getProduct(100)  returns null', () {
      final fakeProductsRepository = buildFakeProductsRepository();
      final product = fakeProductsRepository.getProduct('100');
      expect(product, null);
    });

    test('fetchProducts() returns the global list of products', () async {
      final fakeProductsRepository = buildFakeProductsRepository();
      final products = await fakeProductsRepository.fetchProducts();
      expect(products, kTestProducts);
    });

    test('watchProducts() emits the global list of products', () {
      final fakeProductsRepository = buildFakeProductsRepository();
      final products = fakeProductsRepository.watchProducts();
      expect(products, emits(kTestProducts));
    });

    test('watchProduct(1) emits the first product', () {
      final fakeProductsRepository = buildFakeProductsRepository();
      final product = fakeProductsRepository.watchProduct('1');
      expect(product, emits(kTestProducts.first));
    });

    test('watchProduct(100) emits null', () {
      final fakeProductsRepository = buildFakeProductsRepository();
      final product = fakeProductsRepository.watchProduct('100');
      expect(product, emits(null));
    });
  });
}
