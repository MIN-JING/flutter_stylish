import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../model/banner.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({super.key});

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ClothesCategoryState>();
    var clothes = appState.clothes;

    final mockBannerItems = generateMockBannerItems(20);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        appState.toggleCategory("男裝");
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      child: const Text(
                        "男裝",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: clothes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  print('Item $index clicked');
                                },
                                child: Card(
                                    child: Center(
                                        child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(clothes[index].imageUrl),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(clothes[index].name),
                                            Text(clothes[index].price)
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ))));
                          }),
                    ])
                  ],
                ),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        appState.toggleCategory("女裝");
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      child: const Text(
                        "女裝",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: clothes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  print('Item $index clicked');
                                },
                                child: Card(
                                    child: Center(
                                        child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(clothes[index].imageUrl),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(clothes[index].name),
                                            Text(clothes[index].price)
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ))));
                          }),
                    ])
                  ],
                ),
                const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        appState.toggleCategory("配件");
                      },
                      style:
                          TextButton.styleFrom(backgroundColor: Colors.white),
                      child: const Text(
                        "配件",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                      ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: clothes.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                                onTap: () {
                                  print('Item $index clicked');
                                },
                                child: Card(
                                    child: Center(
                                        child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Image.asset(clothes[index].imageUrl),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(clothes[index].name),
                                            Text(clothes[index].price)
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ))));
                          }),
                    ])
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
