import 'package:ecommerce/features/cart/application/cart_controller.dart';
import 'package:ecommerce/features/products/domain/entities/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailPage extends ConsumerWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
Image.network(
  product.imageUrl,
  height: 200,
  fit: BoxFit.cover,
  errorBuilder: (context, error, stackTrace) => Container(
    height: 200,
    color: Colors.grey,
    child: const Center(child: Icon(Icons.image_not_supported)),
  ),
),

            const SizedBox(height: 16),
            Text(product.description),
            const SizedBox(height: 16),
            Text("\$${product.price.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24)),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                ref.read(cartProvider.notifier).addItem(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Added to cart')),
                );
              },
              child: const Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
