import 'dart:math';

import 'package:faker/faker.dart';

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
    final id = 100 + random.nextInt(99);
    final name = faker.person.name();
    const imageUrl = "assets/images/img_top_banner.png";

    return BannerItem(id: id, name: name, imageUrl: imageUrl);
  });
}
