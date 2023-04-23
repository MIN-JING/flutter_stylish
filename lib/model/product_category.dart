import 'package:flutter/cupertino.dart';
import 'package:flutter_minjing_stylish/model/product.dart';

class ProductCategory {
  final String name;
  final ValueNotifier<List<Product>> products;

  ProductCategory({required this.name, required this.products});
}