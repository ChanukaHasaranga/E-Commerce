import 'package:ecommerce/features/cart/application/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartController = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: cart.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      final item = cart[index];
                      return ListTile(
                        leading: Image.network(
                          item.product.imageUrl,
                          width: 50,
                          height: 50,
                        ),
                        title: Text(item.product.name),
                        subtitle: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("\$${item.product.price.toStringAsFixed(2)} each"),
    Text("Subtotal: \$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
  ],
),

                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  cartController.decreaseQuantity(item),
                            ),
                            Text(item.quantity.toString()),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () =>
                                  cartController.increaseQuantity(item),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => cartController.removeItem(item),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
  "Total: \$${cart.fold(0.0, (sum, item) => sum + item.product.price * item.quantity).toStringAsFixed(2)}",
  style: const TextStyle(fontSize: 20),
),

                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          // simulate checkout
                          final timestamp = DateTime.now();
                          cartController.clearCart();
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              title: const Text('Order Placed'),
                              content: Text(
                                'Order confirmed at ${timestamp.toLocal().toString()}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        },
                        child: const Text('Checkout'),
                      ),
                    ],
                  ),
                ),
              ],
            ),




            
    );
  }
}
