import 'package:flutter_minjing_stylish/model/color.dart';
import 'package:flutter_minjing_stylish/model/variant.dart';

class Product {
  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final String main_image;
  final List<String> images;
  final List<Variant> variants;
  final List<Color> colors;
  final List<String> sizes;

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.main_image,
    required this.images,
    required this.variants,
    required this.colors,
    required this.sizes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      category: json['category'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      texture: json['texture'],
      wash: json['wash'],
      place: json['place'],
      note: json['note'],
      story: json['story'],
      main_image: json['main_image'],
      images: List<String>.from(json['images'].map((x) => x)),
      variants: List<Variant>.from(json['variants'].map((x) => Variant.fromJson(x))),
      colors: List<Color>.from(json['colors'].map((x) => Color.fromJson(x))),
      sizes: List<String>.from(json['sizes'].map((x) => x)),
    );
  }
}