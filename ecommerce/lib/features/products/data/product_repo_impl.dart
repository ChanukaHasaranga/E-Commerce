import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/products/data/models/product_model.dart';
import 'package:ecommerce/features/products/domain/entities/products.dart';
import 'package:ecommerce/features/products/domain/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore firestore;

  ProductRepositoryImpl(this.firestore);

  @override
  Future<List<Product>> fetchProducts() async {
    final snapshot = await firestore.collection('products').get();
    return snapshot.docs
        .map((doc) => ProductModel.fromMap(doc.data(), doc.id))
        .toList();
  }
}
