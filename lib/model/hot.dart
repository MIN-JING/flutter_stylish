import 'package:flutter_minjing_stylish/model/product.dart';

class ResponseHots {
  final List<Hot> hots;

  ResponseHots({
    required this.hots,
  });

  factory ResponseHots.fromJson(Map<String, dynamic> json) {
    return ResponseHots(
      // hots: List<Hot>.from(json['data'].map((x) => Hot.fromJson(x))),
      hots: (json['data'] as List<dynamic>)
          .map((e) => Hot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  // final String title;
  // final List<Product> products;
  //
  // ResponseHots({
  //   required this.title,
  //   required this.products,
  // });
  //
  // factory ResponseHots.fromJson(Map<String, dynamic> json) {
  //   return ResponseHots(
  //     title: json['title'],
  //     products: List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
  //   );
  // }
}

class Hot {
  final String title;
  final List<Product> products;

  Hot({
    required this.title,
    required this.products,
  });

  factory Hot.fromJson(Map<String, dynamic> json) {
    return Hot(
      title: json['title'],
      products: List<Product>.from(json['products'].map((x) => Product.fromJson(x))),
    );
  }
}





