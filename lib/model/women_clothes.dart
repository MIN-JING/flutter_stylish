import 'dart:math';

import 'assesories.dart';

class WomenClothes {
  static final items = [
    ClothesItem(
        id: 201,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
    ClothesItem(
        id: 202,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
    ClothesItem(
        id: 3,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
    ClothesItem(
        id: 4,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
    ClothesItem(
        id: 5,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
    ClothesItem(
        id: 6,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
    ClothesItem(
        id: 7,
        name: "女裝",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 300"),
  ];
}

class ClothesItem {
  final int id;
  final String name;
  final String imageUrl;
  final String price;

  ClothesItem(
      {required this.id,
      required this.name,
      required this.imageUrl,
      required this.price});
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

    return ClothesItem(id: id, name: name, imageUrl: imageUrl, price: price);
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
