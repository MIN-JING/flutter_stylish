import 'dart:math';

import 'package:flutter/material.dart';

import 'assesories.dart';

class ClothesItem {
  final int id;
  final String name;
  final String imageUrl;
  final String price;
  final List<Color> colors;
  final List<String> sizes;

  ClothesItem(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.colors,
      required this.sizes});
}

List<ClothesItem> generateMockClothesItems(int count, String category) {
  final random = Random();

  return List<ClothesItem>.generate(count, (index) {
    final int id;
    final String name;
    final String imageUrl;
    if (category == "男裝") {
      id = 100 + random.nextInt(99);
      name = getRandomClothingName();
      imageUrl = "assets/images/img_clothes_men.png";
    } else if (category == "女裝") {
      id = 200 + random.nextInt(99);
      name = getRandomClothingName();
      imageUrl = "assets/images/img_clothes_women.png";
    } else if (category == "配件") {
      id = 300 + random.nextInt(99);
      name = getRandomAssesoriesName();
      imageUrl = "assets/images/img_assesories.png";
    } else {
      id = 400 + random.nextInt(99);
      name = getRandomClothingName();
      imageUrl = "assets/images/img_top_banner.jpg";
    }

    final price = "NT\$${random.nextInt(10000)}";
    final colors = getRandomClothingColors();
    final sizes = getRandomClothingSizes();

    return ClothesItem(
        id: id,
        name: name,
        imageUrl: imageUrl,
        price: price,
        colors: colors,
        sizes: sizes);
  });
}

String getRandomClothingName() {
  final clothingNames = [
    'T-Shirt',
    '牛仔褲',
    '毛衣',
    '連帽衫',
    '夾克',
    '短袖',
    '半身裙',
    '連身裙',
    '瑜珈褲',
    '外套',
    '襯衫',
    '皮衣',
    '羽絨衣',
    '皮草大衣',
    '羊毛大衣',
  ];

  final random = Random();
  int randomIndex = random.nextInt(clothingNames.length);

  return clothingNames[randomIndex];
}

List<Color> getRandomClothingColors() {
  final clothingColors = [
    Colors.black,
    Colors.white,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.brown,
  ];

  final random = Random();
  int sampleSize = random.nextInt(5) + 1;

  return clothingColors.take(sampleSize).toList();
}

List<String> getRandomClothingSizes() {
  final clothingSizes = [
    'S',
    'M',
    'L',
    'XL',
  ];

  final random = Random();
  int sampleSize = random.nextInt(4);

  return clothingSizes.take(sampleSize).toList();
}
