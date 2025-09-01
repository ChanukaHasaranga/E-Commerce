# Mini E-Commerce Flutter App

## Summary
Mini E-Commerce is a Flutter application built with Clean Architecture principles. Users can browse products, add items to the cart, and checkout. It supports offline cart persistence using Hive and real-time product fetching from Firebase Firestore.

## Architecture
- **Clean Architecture**:
  - **Presentation**: UI pages (HomePage, ProductDetailPage, CartPage, AccountPage)
  - **Application**: State management via Riverpod (CartController)
  - **Domain**: Entities (Product, CartItem)
  - **Data**: Repository implementations interacting with Firestore
- **State Management**: Riverpod
- **Persistence**: Hive for local cart, Firestore for product data
- 
## How to Test
### App
```bash
flutter test 
```

## How to Run
### Web
```bash
flutter run -d chrome
```
### App
```bash
flutter run
```
