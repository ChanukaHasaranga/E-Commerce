import 'package:ecommerce/features/products/domain/entities/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../domain/cart_item.dart';

final cartProvider = StateNotifierProvider<CartController, List<CartItem>>((ref) {
  return CartController();
});

class CartController extends StateNotifier<List<CartItem>> {
  final Box _box = Hive.box('cartBox');

  CartController() : super([]) {
    loadCart();
  }

  void addItem(Product product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index != -1) {
      state[index].quantity++;
    } else {
      state = [...state, CartItem(product: product, quantity: 1)];
    }
    saveCart();
  }

  void removeItem(CartItem item) {
    state = state.where((e) => e.product.id != item.product.id).toList();
    saveCart();
  }

  void increaseQuantity(CartItem item) {
    item.quantity++;
    saveCart();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      removeItem(item);
    }
    saveCart();
  }

  double get total =>
      state.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  void clearCart() {
    state = [];
    saveCart();
  }

  void saveCart() {
    final List<Map<String, dynamic>> cartMap = state
        .map((e) => {'id': e.product.id, 'quantity': e.quantity})
        .toList();
    _box.put('cart', cartMap);
  }

  void loadCart() {
    final List<dynamic>? saved = _box.get('cart');
    if (saved != null) {

      state = [];
    }
  }
}
