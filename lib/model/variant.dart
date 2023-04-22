class Variant {
  final String color_code;
  final String size;
  final int stock;

  Variant({
    required this.color_code,
    required this.size,
    required this.stock,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      color_code: json['color_code'],
      size: json['size'],
      stock: json['stock'],
    );
  }
}