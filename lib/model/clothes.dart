import 'dart:math';

import 'package:flutter/material.dart';

import 'accessories.dart';

class ClothesItem {
  final int id;
  final String name;
  final String imageUrl;
  final String price;
  final List<Color> colors;
  final List<String> sizes;
  final String colorHint;
  final String material;
  final String thickLevel;
  final String materialOrigin;
  final String processOrigin;
  final String flexibility;

  ClothesItem(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price,
      required this.colors,
      required this.sizes,
      required this.colorHint,
      required this.material,
      required this.thickLevel,
      required this.materialOrigin,
      required this.processOrigin,
      required this.flexibility});
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
      name = getRandomAccessories();
      imageUrl = "assets/images/img_accessories.png";
    } else {
      id = 400 + random.nextInt(99);
      name = getRandomClothingName();
      imageUrl = "assets/images/img_top_banner.jpg";
    }

    final price = "NT\$ ${random.nextInt(10000)}";
    final colors = getRandomClothingColors();
    final sizes = getRandomClothingSizes();
    const colorHint = "實品顏色依單品照為主";
    final material = getRandomClothingMaterial();
    final thickLevel = getRandomClothingThick();
    final flexibility = getRandomClothingFlexibility();
    final materialOrigin = getRandomClothingOrigin();
    final processOrigin = getRandomClothingOrigin();

    return ClothesItem(
        id: id,
        name: name,
        imageUrl: imageUrl,
        price: price,
        colors: colors,
        sizes: sizes,
        colorHint: colorHint,
        material: material,
        thickLevel: thickLevel,
        flexibility: flexibility,
        materialOrigin: materialOrigin,
        processOrigin: processOrigin);
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
  int sampleSize = random.nextInt(4) + 1;

  return clothingSizes.take(sampleSize).toList();
}

String getRandomClothingMaterial() {
  final clothingMaterial = [
    '棉 100%',
    '棉 80% / 聚酯纖維 20%',
    '棉 70% / 聚酯纖維 30%',
    '棉 60% / 聚酯纖維 40%',
    '聚酯纖維 100%',
    '聚酯纖維 80% / 棉 20%',
    '天然蠶絲 100%',
    '羊毛 100%',
    '鵝絨 100%',
  ];

  final random = Random();
  int randomIndex = random.nextInt(clothingMaterial.length);

  return clothingMaterial[randomIndex];
}

String getRandomClothingThick() {
  final clothingThick = [
    '薄',
    '厚',
  ];

  final random = Random();
  int randomIndex = random.nextInt(clothingThick.length);

  return clothingThick[randomIndex];
}

String getRandomClothingFlexibility() {
  final clothingFlexibility = [
    '有',
    '無',
  ];

  final random = Random();
  int randomIndex = random.nextInt(clothingFlexibility.length);

  return clothingFlexibility[randomIndex];
}

String getRandomClothingOrigin() {
  final clothingOrigin = [
    "台灣",
    "日本",
    "韓國",
    "美國",
    "英國",
    "中國",
    "菲律賓",
    "印尼",
    "越南",
    "泰國",
  ];

  final random = Random();
  int randomIndex = random.nextInt(clothingOrigin.length);

  return clothingOrigin[randomIndex];
}
