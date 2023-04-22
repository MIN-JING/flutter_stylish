import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/market_campaign.dart';

import '../model/clothes.dart';
import '../model/home_data.dart';
import '../page/home_mobile.dart';
import '../page/home_web.dart';

import 'package:provider/provider.dart';
import '../bloc/application_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    required this.title,
    required this.homeData
  }) : super(key: key);

  final String title;
  final HomeData homeData;

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
            ValueListenableBuilder<List<MarketCampaign>>(
              valueListenable: widget.homeData.marketCampaigns,
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
            ValueListenableBuilder<List<ClothesItem>>(
              valueListenable: widget.homeData.womenClothes,
              builder: (context, clothesItems, _) {
                return isMobile
                    ? HomeMobile(
                  isMobile: isMobile,
                )
                    : HomeWeb(
                  isMobile: isMobile,
                  menClothes: widget.homeData.womenClothes.value,
                  womenClothes: widget.homeData.womenClothes.value,
                  accessories: widget.homeData.womenClothes.value,
                  onButtonClicked: (category) {
                    // appState.toggleCategory(category);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}