import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/banner.dart';
import 'package:flutter_minjing_stylish/model/women_clothes.dart';
import 'package:provider/provider.dart';

import 'home/home_mobile.dart';
import 'home/home_web.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ClothesCategoryState(),
        child: MaterialApp(
          title: "Flutter Stylish Jim App",
          theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
          home: const MyHomePage(title: '商品概覽'),
        ));
  }
}

class ClothesCategoryState extends ChangeNotifier {
  var clothesCategory = "女裝";
  var clothes = <ClothesItem>[];

  void toggleCategory(String category) {
    log("toggleCategory: $category");
    clothesCategory = category;
    clothes = generateMockClothesItems(20, category);
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ClothesCategoryState>();

    final mockBannerItems = generateMockBannerItems(20);

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
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: mockBannerItems.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Center(
                      child: Image.asset(mockBannerItems[index].imageUrl),
                    ));
                  }),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            isMobile
                ? HomeMobile(
                    isMobile: isMobile,
                    clothes: appState.clothes,
                    onButtonClicked: (category) {
                      appState.toggleCategory(category);
                    },
                  )
                : HomeWeb(
                    menClothes: generateMockClothesItems(20, "男裝"),
                    womenClothes: generateMockClothesItems(20, "女裝"),
                    assesories: generateMockClothesItems(20, "配件"),
                    onButtonClicked: (category) {
                      appState.toggleCategory(category);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
