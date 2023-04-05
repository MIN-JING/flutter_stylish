import 'package:flutter/material.dart';

import '../model/women_clothes.dart';

class HomeWeb extends StatefulWidget {
  final ValueChanged<String> onButtonClicked;
  final List<ClothesItem> menClothes;
  final List<ClothesItem> womenClothes;
  final List<ClothesItem> assesories;
  const HomeWeb(
      {Key? key,
      required this.onButtonClicked,
      required this.menClothes,
      required this.womenClothes,
      required this.assesories})
      : super(key: key);

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                widget.onButtonClicked("男裝");
              },
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "男裝",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.menClothes.length,
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
                          Image.asset(
                            widget.menClothes[index].imageUrl,
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.menClothes[index].name),
                                  Text(widget.menClothes[index].price)
                                ],
                              )
                            ],
                          )
                        ],
                      ))));
                }),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () {
                widget.onButtonClicked("女裝");
              },
              style: TextButton.styleFrom(backgroundColor: Colors.white),
              child: const Text(
                "女裝",
                style: TextStyle(color: Colors.black),
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: widget.womenClothes.length,
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
                          Image.asset(
                            widget.womenClothes[index].imageUrl,
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(widget.womenClothes[index].name),
                                  Text(widget.womenClothes[index].price)
                                ],
                              )
                            ],
                          )
                        ],
                      ))));
                }),
          ],
        ),
      ),
      const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
      Expanded(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () {
              widget.onButtonClicked("配件");
            },
            style: TextButton.styleFrom(backgroundColor: Colors.white),
            child: const Text(
              "配件",
              style: TextStyle(color: Colors.black),
            ),
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.assesories.length,
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
                        Image.asset(
                          widget.assesories[index].imageUrl,
                          width: 100,
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.assesories[index].name),
                                Text(widget.assesories[index].price)
                              ],
                            )
                          ],
                        )
                      ],
                    ))));
              }),
        ],
      )),
    ]);
  }
}
