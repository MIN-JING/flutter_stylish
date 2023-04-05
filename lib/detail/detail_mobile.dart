import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/women_clothes.dart';

class DetailMobile extends StatefulWidget {
  final ClothesItem clothesItem;
  const DetailMobile({super.key, required this.clothesItem});

  @override
  State<DetailMobile> createState() => _DetailMobileState();
}

class _DetailMobileState extends State<DetailMobile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
                height: 500,
                child: Image.asset(
                  widget.clothesItem.imageUrl,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )),
            const Padding(padding: EdgeInsets.fromLTRB(0, 24, 0, 0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(widget.clothesItem.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 26)),
              ],
            ),
            const Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0)),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                widget.clothesItem.id.toString(),
                style: const TextStyle(fontSize: 20),
              ),
            ]),
            const Padding(padding: EdgeInsets.fromLTRB(0, 32, 0, 0)),
            Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Text(
                widget.clothesItem.price.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ]),
            const Divider(
              color: Colors.grey, // Customize the divider color
              thickness: 2, // Customize the divider thickness
              height: 32, // Customize the space around the divider
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "顏色",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                    child: VerticalDivider(
                      color: Colors.grey, // Customize the divider color
                      thickness: 2, // Customize the divider thickness
                      width: 32, // Customize the space around the divider
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.clothesItem.colors.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              log('Color Item $index clicked');
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: widget.clothesItem.colors[index],
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      },
                    ),
                  )
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "尺寸",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                    child: VerticalDivider(
                      color: Colors.grey, // Customize the divider color
                      thickness: 2, // Customize the divider thickness
                      width: 32, // Customize the space around the divider
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.clothesItem.sizes.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              log('Color Item $index clicked');
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(4, 0, 8, 0),
                              child: Container(
                                width: 30,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey,
                                  borderRadius: BorderRadius.circular(50),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(0, 1),
                                    ),
                                  ],
                                ),
                                child: Text(widget.clothesItem.sizes[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                        ),
                              ),
                            ));
                      },
                    ),
                  )
                ]),
          ],
        ),
      ),
    );
  }
}
