import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/assesories.dart';
import 'package:flutter_minjing_stylish/model/men_clothes.dart';
import 'package:flutter_minjing_stylish/widget/banner_widget.dart';
import 'package:flutter_minjing_stylish/model/banner.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_minjing_stylish/model/women_clothes.dart';
import 'package:provider/provider.dart';

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
    clothesCategory = category;
    if (category == "女裝") {
      clothes = WomenClothes.items;
    } else if (category == "男裝") {
      clothes = MenClothes.items;
    } else if (category == "配件") {
      clothes = Assesories.items;
    }
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
    var clothes = appState.clothes;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Stylish",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        // scrollDirection: Axis.horizontal,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            SizedBox(
              height: 100.0,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: TopBanner.items.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Center(
                      child: Image.asset(TopBanner.items[index].imageUrl),
                    ));
                  }),
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    appState.toggleCategory("男裝");
                  },
                  child: Text(
                    "男裝",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                TextButton(
                  onPressed: () {
                    appState.toggleCategory("女裝");
                  },
                  child: Text(
                    "女裝",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                ),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                TextButton(
                  onPressed: () {
                    appState.toggleCategory("配件");
                  },
                  child: Text(
                    "配件",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: TextButton.styleFrom(backgroundColor: Colors.white),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
            Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: clothes.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(clothes[index].imageUrl),
                          Column(mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(clothes[index].name),
                            Text(clothes[index].price)
                          ],)
                          
                        ],
                      )
                    ));
                  }),
            ])
          ],
        ),
      ),
    );
  }
}
