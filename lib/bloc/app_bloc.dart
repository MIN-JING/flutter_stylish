import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_minjing_stylish/model/clothes.dart';
import 'package:flutter_minjing_stylish/model/market_campaign.dart';
import 'package:flutter_minjing_stylish/network/api_service.dart';

class ApplicationBloc {
  ValueNotifier<List<MarketCampaign>> marketCampaignsNotifier =
      ValueNotifier<List<MarketCampaign>>([]);

  ValueNotifier<List<ClothesItem>> clothesItemsNotifier =
      ValueNotifier<List<ClothesItem>>([]);

  ApplicationBloc() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    final List<dynamic> marketCampaignsJson = await getMarketCampaign();
    final List<MarketCampaign> marketCampaigns = marketCampaignsJson
        .map((jsonCampaign) => MarketCampaign.fromJson(jsonCampaign))
        .toList();

    // final marketCampaigns = await getMarketCampaign();
    final clothesItems = generateMockClothesItems(20, "男裝");

    marketCampaignsNotifier.value = marketCampaigns;
    clothesItemsNotifier.value = clothesItems;
  }
}

// class ApplicationBloc implements BlocBase {
//   final StreamController<List<MarketCampaign>?> _syncController =
//       StreamController<List<MarketCampaign>?>.broadcast();
//   Stream<List<MarketCampaign>?> get outMarketCampaigns =>
//       _syncController.stream;

//   final StreamController<List<MarketCampaign>?> _cmdController =
//       StreamController<List<MarketCampaign>?>.broadcast();
//   StreamSink get getMarketCampaigns => _cmdController.sink;

//   ApplicationBloc() {
//     getMarketCampaign().then((list) {
//       _campaignList = list as ResponseMarketCampaign?;
//     });

//     _cmdController.stream.listen((_) {
//       _syncController.sink.add(UnmodifiableListView<MarketCampaign>(
//           _campaignList?.marketCampaign ?? []));
//     });
//   }

//   @override
//   void dispose() {
//     _syncController.close();
//     _cmdController.close();
//   }

//   ResponseMarketCampaign? _campaignList;
// }