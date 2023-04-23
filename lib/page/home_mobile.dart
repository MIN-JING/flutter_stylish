import 'dart:developer';

import 'package:flutter_minjing_stylish/model/home_data.dart';
import 'package:flutter_minjing_stylish/model/product_category.dart';

import '../model/product.dart';
import 'detail.dart';

import 'package:flutter/material.dart';

class HomeMobile extends StatefulWidget {
  final bool isMobile;
  final HomeData homeData;
  final List<ProductCategory> productCategories;

  const HomeMobile({
    Key? key,
    required this.isMobile,
    required this.homeData,
    required this.productCategories,
  }) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  void _toggleCategory(String category) {
    // Implement the toggleCategory logic
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ...widget.productCategories.map<Widget>((category) {
          return Column(
            children: [
              TextButton(
                onPressed: () {
                  _toggleCategory(category.name);
                },
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: Text(
                  category.name,
                  style: const TextStyle(color: Colors.black),
                ),
              ),
              const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
              ValueListenableBuilder<List<Product>>(
                valueListenable: category.products,
                builder: (context, clothesItems, child) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: clothesItems.length,
                      itemBuilder: (context, index) {
                        final clothesItem = clothesItems[index];
                        return GestureDetector(
                            onTap: () {
                              log('Item $index clicked');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailPage(
                                    title: "商品細節",
                                    isMobile: widget.isMobile,
                                    product: clothesItem,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                                child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Image.asset(
                                          clothesItem.main_image,
                                          width: 100,
                                          height: 100,
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: <Widget>[
                                                Text(clothesItem.title),
                                                Text(clothesItem.price.toString())
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ))));
                      });
                },
              ),
            ],
          );
        }).toList(),
      ],
    );
  }
}
