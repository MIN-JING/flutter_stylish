import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/women_clothes.dart';
import '../detail/detail_mobile.dart';

class DetailPage extends StatefulWidget {
  final bool isMobile;
  final ClothesItem clothesItem;
  const DetailPage(
      {super.key,
      required this.title,
      required this.isMobile,
      required this.clothesItem});

  final String title;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Stylish",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: widget.isMobile
              ? DetailMobile(clothesItem: widget.clothesItem)
              : DetailMobile(clothesItem: widget.clothesItem),
        ));
  }
}
