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
