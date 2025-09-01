import 'package:ecommerce/features/products/domain/entities/products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../domain/cart_item.dart';

final cartProvider = StateNotifierProvider<CartController, List<CartItem>>((
  ref,
) {
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
  state = [
    for (final i in state)
      if (i.product.id == item.product.id)
        CartItem(product: i.product, quantity: i.quantity + 1)
      else
        i
  ];
  saveCart();
}

void decreaseQuantity(CartItem item) {
  state = [
    for (final i in state)
      if (i.product.id == item.product.id)
        if (i.quantity > 1)
          CartItem(product: i.product, quantity: i.quantity - 1)
        else
          null
      else
        i
  ].whereType<CartItem>().toList();
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
        .map(
          (e) => {
            'id': e.product.id,
            'name': e.product.name,
            'description': e.product.description,
            'price': e.product.price,
            'imageUrl': e.product.imageUrl,
            'quantity': e.quantity,
          },
        )
        .toList();
    _box.put('cart', cartMap);
  }

  void loadCart() {
    final List<dynamic>? saved = _box.get('cart');
    if (saved != null) {
      state = saved.map((e) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(e);
        return CartItem(
          product: Product(
            id: map['id'],
            name: map['name'],
            description: map['description'],
            price: map['price'],
            imageUrl: map['imageUrl'],
          ),
          quantity: map['quantity'],
        );
      }).toList();
    }
  }
}
