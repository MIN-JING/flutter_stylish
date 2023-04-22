import 'dart:developer';

import 'package:flutter/material.dart';

import 'detail.dart';
import '../model/clothes.dart';

class HomeWeb extends StatefulWidget {
  final bool isMobile;
  final ValueChanged<String> onButtonClicked;
  final List<ClothesItem> menClothes;
  final List<ClothesItem> womenClothes;
  final List<ClothesItem> accessories;
  const HomeWeb(
      {Key? key,
      required this.isMobile,
      required this.onButtonClicked,
      required this.menClothes,
      required this.womenClothes,
      required this.accessories})
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
                        log('Item $index clicked');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                title: "商品細節",
                                isMobile: widget.isMobile,
                                clothesItem: widget.menClothes[index]),
                          ),
                        );
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
                        log('Item $index clicked');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                                title: "商品細節",
                                isMobile: widget.isMobile,
                                clothesItem: widget.womenClothes[index]),
                          ),
                        );
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
              itemCount: widget.accessories.length,
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
                                clothesItem: widget.accessories[index]),
                          ),
                        );
                    },
                    child: Card(
                        child: Center(
                            child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image.asset(
                          widget.accessories[index].imageUrl,
                          width: 100,
                          height: 100,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.accessories[index].name),
                                Text(widget.accessories[index].price)
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
