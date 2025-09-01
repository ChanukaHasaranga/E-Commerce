import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce/features/products/domain/entities/products.dart';
import 'package:ecommerce/features/products/presentation/pages/product_details.dart';
import 'package:hive_test/hive_test.dart';
import 'package:hive/hive.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  setUp(() async {
    await setUpTestHive(); // Initialize Hive in memory
    await Hive.openBox('cartBox'); // Open the box used by CartController
  });

  tearDown(() async {
    await tearDownTestHive();
  });

  testWidgets('Add to cart button shows SnackBar', (WidgetTester tester) async {
    final testProduct = Product(
      id: 'p1',
      name: 'Test Product',
      description: 'Desc',
      price: 10.0,
      imageUrl: 'https://example.com/image.png',
    );

    // Mock network images to avoid HttpClient errors
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: ProductDetailPage(product: testProduct),
          ),
        ),
      );

      // Tap the Add to Cart button
      await tester.tap(find.text('Add to Cart'));
      await tester.pump(); // rebuild after tap

      // Verify SnackBar appears
      expect(find.text('Added to cart'), findsOneWidget);
    });
  });
}
