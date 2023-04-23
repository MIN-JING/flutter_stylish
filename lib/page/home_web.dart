import 'dart:developer';

import 'package:flutter/material.dart';

import '../model/home_data.dart';
import '../model/product.dart';
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
              ValueListenableBuilder<List<Product>>(
                valueListenable: category.products,
                builder: (context, products, child) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          log('Item $index clicked');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                  title: "商品細節",
                                  isMobile: widget.isMobile,
                                  product: products[index]),
                            ),
                          );
                        },
                        child: Card(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Image.network(
                                  products[index].main_image,
                                  width: 100,
                                  height: 100,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(products[index].title),
                                    Text(products[index].price.toString()),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                })
            ],
          ),
        );
      }).toList(),
    );
  }
}