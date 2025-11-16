import '../../../constants/test_products.dart';
import '../domain/product.dart';

class FakeProductsRepository {
  static final FakeProductsRepository instance =
      FakeProductsRepository._instance();

  FakeProductsRepository._instance();

  List<Product> getProducts() => kTestProducts;
}
