import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/market_campaign.dart';

import '../model/clothes.dart';
import '../home/home_mobile.dart';
import '../home/home_web.dart';

import 'package:provider/provider.dart';
import '../bloc/app_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key,
      required this.title,
      required this.marketCampaigns,
      required this.clothesItems});

  final String title;
  final List<MarketCampaign> marketCampaigns;
  final List<ClothesItem> clothesItems;

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
            Consumer<ApplicationBloc>(
              builder: (context, applicationBloc, child) {
                return SizedBox(
                  height: 100.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        applicationBloc.marketCampaignsNotifier.value.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Center(
                        child: Image.network(
                          applicationBloc
                              .marketCampaignsNotifier.value[index].picture,
                          errorBuilder: (context, error, stackTrace) {
                            print(error.toString());
                            return const Text("Error loading image");
                          },
                        ),
                      ));
                    },
                  ),
                );
              },
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
                      // appState.toggleCategory(category);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}




// class _HomePageState extends State<HomePage> {
//   List<dynamic> _campaigns = [];

//   @override
//   void initState() {
//     super.initState();
//     getMarketCampaign().then((campaigns) {
//       setState(() {
//         _campaigns = campaigns;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final generalBloc = context.watch<GeneralBloc>();

//     double screenWidth = MediaQuery.of(context).size.width;
//     bool isMobile = screenWidth < 600;

//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: const Text(
//           "Stylish",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
//             SizedBox(
//               height: 100.0,
//               child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   physics: const ClampingScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: _campaigns.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                         child: Center(
//                       child: Image.network(
//                         _campaigns[index]['picture'],
//                         errorBuilder: (context, error, stackTrace) {
//                           print(error.toString());
//                           return const Text("Error loading image");
//                         },
//                       ),
//                     ));
//                   }),
//             ),
//             const Padding(padding: EdgeInsets.fromLTRB(10, 20, 10, 20)),
//             isMobile
//                 ? HomeMobile(
//                     isMobile: isMobile,
//                   )
//                 : HomeWeb(
//                     isMobile: isMobile,
//                     menClothes: generateMockClothesItems(20, "男裝"),
//                     womenClothes: generateMockClothesItems(20, "女裝"),
//                     assesories: generateMockClothesItems(20, "配件"),
//                     onButtonClicked: (category) {
//                       appState.toggleCategory(category);
//                     },
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
