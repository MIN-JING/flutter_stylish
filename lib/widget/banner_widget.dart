import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/banner.dart';

class BannerItemWidget extends StatelessWidget {
  final BannerItem item;
  const BannerItemWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 0,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(item.imageUrl),
        ),
      ),
    );
  }
}
