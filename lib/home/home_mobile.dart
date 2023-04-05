import 'package:flutter/material.dart';

import '../model/women_clothes.dart';

class HomeMobile extends StatefulWidget {
  final ValueChanged<String> onButtonClicked;
  final List<ClothesItem> clothes;
  const HomeMobile(
      {Key? key, required this.clothes, required this.onButtonClicked})
      : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
            const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
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
          ],
        ),
        const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          ListView.builder(
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.clothes.length,
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
                          widget.clothes[index].imageUrl,
                          width: 100,
                          height: 100,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(widget.clothes[index].name),
                                Text(widget.clothes[index].price)
                              ],
                            )
                          ],
                        )
                      ],
                    ))));
              }),
        ])
      ],
    );
  }
}
