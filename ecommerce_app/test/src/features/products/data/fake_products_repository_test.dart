import 'package:ecommerce_app/src/constants/test_products.dart';
import 'package:ecommerce_app/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getProducts() returns global list of products', () {
    final fakeProductsRepository = FakeProductsRepository();
    final products = fakeProductsRepository.getProducts();
    expect(products, kTestProducts);
  });

  test('getProduct(1) returns the first product ', () {
    final fakeProductsRepository = FakeProductsRepository();
    final product = fakeProductsRepository.getProduct('1');
    expect(product, kTestProducts.first);
  });

  test('getProduct(100) returns null', () {
    final fakeProductsRepository = FakeProductsRepository();
    product() => fakeProductsRepository.getProduct('100');
    expect(product, throwsStateError);
  });
}
