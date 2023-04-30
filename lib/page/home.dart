import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/campaign.dart';

import '../model/home_data.dart';
import '../model/product_category.dart';
import '../page/home_mobile.dart';
import '../page/home_web.dart';
import 'map_google.dart';

class HomePage extends StatefulWidget {
  final String title;
  final HomeData homeData;

  const HomePage({
    Key? key,
    required this.title,
    required this.homeData
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            ValueListenableBuilder<List<Campaign>>(
              valueListenable: widget.homeData.campaigns,
              builder: (context, marketCampaigns, _) {
                return SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: marketCampaigns.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Center(
                          child: Image.network(
                            marketCampaigns[index].picture,
                            errorBuilder: (context, error, stackTrace) {
                              if (kDebugMode) {
                                print(error.toString());
                              }
                              return const Text("Error loading image");
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            TextButton(
                onPressed: () {
                  if (kDebugMode) {
                    print("點擊地圖按鈕");
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapGooglePage(
                        title: "地圖",
                        isMobile: isMobile,
                      ),
                    ),
                  );
                },
                style: TextButton.styleFrom(backgroundColor: Colors.white),
                child: const Text("地圖", style: TextStyle(color: Colors.black))),
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            isMobile
              ? HomeMobile(
                  isMobile: isMobile,
                  homeData: widget.homeData,
                  productCategories: [
                    ProductCategory(name: 'women', products: widget.homeData.productsWomen),
                    ProductCategory(name: 'men', products: widget.homeData.productsMen),
                    ProductCategory(name: 'accessories', products: widget.homeData.productsAccessories),
                  ],
                )
              : HomeWeb(
                  isMobile: isMobile,
                  homeData: widget.homeData,
                  onButtonClicked: (category) {
                    // appState.toggleCategory(category);
                  },
                  productCategories: [
                    ProductCategory(name: 'women', products: widget.homeData.productsWomen),
                    ProductCategory(name: 'men', products: widget.homeData.productsMen),
                    ProductCategory(name: 'accessories', products: widget.homeData.productsAccessories),
                  ],
              ),
          ],
        ),
      ),
    );
  }
}