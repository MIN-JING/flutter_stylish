import 'package:flutter/material.dart';
import '../model/product.dart';
import 'detail_mobile.dart';

class DetailPage extends StatefulWidget {
  final bool isMobile;
  final Product product;
  const DetailPage(
      {super.key,
      required this.title,
      required this.isMobile,
      required this.product});

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
              ? DetailMobile(product: widget.product)
              : DetailMobile(product: widget.product),
        ));
  }
}
