
import 'package:ecommerce/features/products/domain/entities/products.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts();
}
