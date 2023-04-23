import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/home_data.dart';
import '../model/product_category.dart';
import 'detail.dart';

class HomeWeb extends StatefulWidget {
  final bool isMobile;
  final HomeData homeData;
  final Function(ProductCategory) onButtonClicked;
  final List<ProductCategory> productCategories;

  const HomeWeb({
    Key? key,
    required this.isMobile,
    required this.homeData,
    required this.onButtonClicked,
    required this.productCategories,
  }) : super(key: key);

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.productCategories.map<Widget>((category) {
        return Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  widget.onButtonClicked(category);
                },
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text(
                  category.name,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: category.products.value.length,
                itemBuilder: (context, index) {
                  final product = category.products.value[index];
                  return GestureDetector(
                    onTap: () {
                      log('Item $index clicked');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                              title: "商品細節",
                              isMobile: widget.isMobile,
                              product: product),
                        ),
                      );
                    },
                    child: Card(
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Image.asset(
                              product.main_image,
                              width: 100,
                              height: 100,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(product.title),
                                Text(product.price.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}