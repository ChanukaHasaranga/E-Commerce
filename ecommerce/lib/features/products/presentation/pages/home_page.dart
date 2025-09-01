import 'package:ecommerce/features/account/presentation/pages/account_page.dart';
import 'package:ecommerce/features/cart/presentation/pages/cart_page.dart';
import 'package:ecommerce/features/products/data/product_repo_impl.dart';
import 'package:ecommerce/features/products/domain/entities/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final productListProvider = FutureProvider<List<Product>>((ref) async {
  final repo = ProductRepositoryImpl(FirebaseFirestore.instance);
  return repo.fetchProducts();
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      _buildHomeTab(),
      const CartPage(),
      const AccountPage(),
    ];

    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }

  Widget _buildHomeTab() {
    final productsAsync = ref.watch(productListProvider);

    return productsAsync.when(
      data: (products) {
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              leading: Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
              title: Text(product.name),
              subtitle: Text("\$${product.price.toStringAsFixed(2)}"),
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
    );
  }
}
