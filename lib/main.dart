import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/banner.dart';
import 'package:flutter_minjing_stylish/model/clothes.dart';

import 'cart/cart_inherited_widget.dart';
import 'home/home_mobile.dart';
import 'home/home_web.dart';
import 'model/cart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppState appState = AppState();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CartInheritedWidget(
      appState: appState,
      child: MaterialApp(
        title: 'Flutter Stylish Jim App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        ),
        home: const MyHomePage(title: '商品概覽'),
      ),
    );
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

class AppState extends ChangeNotifier {
  final Cart _cart = Cart();
  final ClothesCategoryState _clothesCategoryState = ClothesCategoryState();

  Cart get cart => _cart;
  ClothesCategoryState get clothesCategoryState => _clothesCategoryState;

  void toggleCategory(String category) {
    _clothesCategoryState.toggleCategory(category);
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
    final appState = CartInheritedWidget.of(context)?.appState ?? AppState();

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
                  )
                : HomeWeb(
                    isMobile: isMobile,
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
