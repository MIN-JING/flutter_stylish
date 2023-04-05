import 'dart:math';

import 'package:flutter_minjing_stylish/model/women_clothes.dart';

class Assesories {
  static final items = [
    ClothesItem(
        id: 1,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
    ClothesItem(
        id: 2,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
    ClothesItem(
        id: 3,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
    ClothesItem(
        id: 4,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
    ClothesItem(
        id: 5,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
    ClothesItem(
        id: 6,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
    ClothesItem(
        id: 7,
        name: "配件",
        imageUrl: "assets/images/bg_home_top.jfif",
        price: "NT\$ 50"),
  ];
}

String getRandomAssesoriesName() {
  final assesoriesNames = [
    '皮帶',
    '手套',
    '帽子',
    '襪子',
    '圍巾',
    '鞋子',
    '皮包',
    '手提包',
    '領帶',
    '領帶夾',
  ];

  final random = Random();
  int randomIndex = random.nextInt(assesoriesNames.length);

  return assesoriesNames[randomIndex];
}
