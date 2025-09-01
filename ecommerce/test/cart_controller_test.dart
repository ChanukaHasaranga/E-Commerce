import 'package:flutter_test/flutter_test.dart';
import 'package:hive_test/hive_test.dart';
import 'package:hive/hive.dart';
import 'package:ecommerce/features/cart/application/cart_controller.dart';
import 'package:ecommerce/features/products/domain/entities/products.dart';

void main() {
  setUp(() async {
    // Initialize Hive in memory for testing
    await setUpTestHive();
    await Hive.openBox('cartBox');
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  group('CartController', () {
    test('calculates total correctly', () {
      final controller = CartController();

      final product1 = Product(
        id: 'p1',
        name: 'Product 1',
        description: 'Desc',
        price: 10.0,
        imageUrl: 'url',
      );

      final product2 = Product(
        id: 'p2',
        name: 'Product 2',
        description: 'Desc',
        price: 15.0,
        imageUrl: 'url',
      );

      controller.addItem(product1); // quantity 1
      controller.addItem(product2); // quantity 1
      controller.addItem(product1); // quantity 2 for product1

      expect(controller.total, 35); // 10*2 + 15*1
    });
  });
}
