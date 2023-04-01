import 'dart:math';

import 'package:faker/faker.dart';

class TopBanner {
  static final items = [
    BannerItem(
      id: 101,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 102,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 103,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 104,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 105,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 106,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 107,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
  ];
}

class BannerItem {
  final int id;
  final String name;
  final String imageUrl;

  BannerItem({
    required this.id,
    required this.name,
    required this.imageUrl,
  });
}

List<BannerItem> generateMockBannerItems(int count) {
  final faker = Faker();
  final random = Random();

  return List<BannerItem>.generate(count, (index) {
    final id = random.nextInt(100000);
    final name = faker.person.name();
    const imageUrl = "assets/images/img_top_banner.jpg";
    // final imageUrl = 'https://i.pravatar.cc/150?img=${random.nextInt(100)}';
    // const imageUrl = "assets/images/bg_home_top.jfif";

    return BannerItem(id: id, name: name, imageUrl: imageUrl);
  });
}
