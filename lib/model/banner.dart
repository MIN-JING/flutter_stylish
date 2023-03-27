class TopBanner {
  static final items = [
    BannerItem(
      id: 1,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 2,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 3,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 4,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 5,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 6,
      name: "盤子",
      imageUrl: "assets/images/bg_home_top.jfif",
    ),
    BannerItem(
      id: 7,
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