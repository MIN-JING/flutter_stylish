import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/product.dart';

class Cart extends ChangeNotifier {
  // Make the list private
  final List<Product> _products = [];

  // Expose the list through a getter
  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  bool removeProduct(Product product) {
    final removed = _products.remove(product);
    if (removed) {
      notifyListeners();
    }
    return removed;
  }

  void clearProducts() {
    products.clear();
  }
}
