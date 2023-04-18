import 'dart:developer';

import 'package:flutter_minjing_stylish/bloc/app_bloc.dart';
import 'package:provider/provider.dart';

import '../detail/detail.dart';

import 'package:flutter/material.dart';

import '../model/clothes.dart';

class HomeMobile extends StatefulWidget {
  final bool isMobile;

  const HomeMobile({Key? key, required this.isMobile}) : super(key: key);

  @override
  State<HomeMobile> createState() => _HomeMobileState();
}

class _HomeMobileState extends State<HomeMobile> {
  void _toggleCategory(String category) {
    // Implement the toggleCategory logic
  }

  @override
  Widget build(BuildContext context) {
    final appBloc = Provider.of<ApplicationBloc>(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        TextButton(
          onPressed: () {
            _toggleCategory("男裝");
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
            _toggleCategory("女裝");
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
            _toggleCategory("配件");
          },
          style: TextButton.styleFrom(backgroundColor: Colors.white),
          child: const Text(
            "配件",
            style: TextStyle(color: Colors.black),
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
        ValueListenableBuilder<List<ClothesItem>>(
          valueListenable: appBloc.clothesItemsNotifier,
          builder: (context, clothesItems, child) {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: clothesItems.length,
                itemBuilder: (context, index) {
                  final clothesItem = clothesItems[index];
                  return GestureDetector(
                      onTap: () {
                        log('Item $index clicked');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              title: "商品細節",
                              isMobile: widget.isMobile,
                              clothesItem: clothesItem,
                            ),
                          ),
                        );
                      },
                      child: Card(
                          child: Center(
                              child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            clothesItem.imageUrl,
                            width: 100,
                            height: 100,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Text(clothesItem.name),
                                  Text(clothesItem.price)
                                ],
                              )
                            ],
                          )
                        ],
                      ))));
                });
          },
        ),
      ],
    );
  }
}


// class _HomeMobileState extends State<HomeMobile> {
//   void _toggleCategory(String category) {
//     CartInheritedWidget.of(context)?.appState.toggleCategory(category);
//   }

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     CartInheritedWidget.of(context)?.appState.addListener(_updateClothesList);
//   }

//   @override
//   void dispose() {
//     CartInheritedWidget.of(context)
//         ?.appState
//         .removeListener(_updateClothesList);
//     super.dispose();
//   }

//   void _updateClothesList() {
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     final appState = CartInheritedWidget.of(context)?.appState ?? AppState();

//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             TextButton(
//               onPressed: () {
//                 _toggleCategory("男裝");
//               },
//               style: TextButton.styleFrom(backgroundColor: Colors.white),
//               child: const Text(
//                 "男裝",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
//             TextButton(
//               onPressed: () {
//                 _toggleCategory("女裝");
//               },
//               style: TextButton.styleFrom(backgroundColor: Colors.white),
//               child: const Text(
//                 "女裝",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//             const Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
//             TextButton(
//               onPressed: () {
//                 _toggleCategory("配件");
//               },
//               style: TextButton.styleFrom(backgroundColor: Colors.white),
//               child: const Text(
//                 "配件",
//                 style: TextStyle(color: Colors.black),
//               ),
//             ),
//           ],
//         ),
//         const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
//         Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
//           ListView.builder(
//               scrollDirection: Axis.vertical,
//               physics: const ClampingScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: appState.clothesCategoryState.clothes.length,
//               itemBuilder: (context, index) {
//                 return GestureDetector(
//                     onTap: () {
//                       log('Item $index clicked');
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailPage(
//                             title: "商品細節",
//                             isMobile: widget.isMobile,
//                             clothesItem:
//                                 appState.clothesCategoryState.clothes[index],
//                           ),
//                         ),
//                       );
//                     },
//                     child: Card(
//                         child: Center(
//                             child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Image.asset(
//                           appState.clothesCategoryState.clothes[index].imageUrl,
//                           width: 100,
//                           height: 100,
//                         ),
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: <Widget>[
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 Text(appState
//                                     .clothesCategoryState.clothes[index].name),
//                                 Text(appState
//                                     .clothesCategoryState.clothes[index].price)
//                               ],
//                             )
//                           ],
//                         )
//                       ],
//                     ))));
//               }),
//         ])
//       ],
//     );
//   }
// }
