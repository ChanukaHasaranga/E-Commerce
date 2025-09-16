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
    // Initialize Hive in memory
    await setUpTestHive(); 
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
      imageUrl: 'https://pics.clipartpng.com/midle/Blue_T_Shirt_PNG_Clipart-2346.png',
    );

    // Mock network images to avoid HttpClient errors
    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: Scaffold(
              body: ProductDetailPage(product: testProduct),
            ),
          ),
        ),
      );

      // Tap the Add to Cart button
      await tester.tap(find.text('Add to Cart'));
      
      // Pump to start the SnackBar animation
      await tester.pump(); 
      
      // Pump for duration of SnackBar animation to appear
      await tester.pump(const Duration(seconds: 1));

      // Verify SnackBar appears by text
      expect(find.text('Added to cart'), findsOneWidget);

      // Optional: verify SnackBar appears by type
      expect(find.byType(SnackBar), findsOneWidget);
    });
  });
}
