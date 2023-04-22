import 'dart:async';

import 'package:flutter_minjing_stylish/model/clothes.dart';
import 'package:flutter_minjing_stylish/model/market_campaign.dart';
import 'package:flutter_minjing_stylish/network/api_service.dart';

import '../model/cart.dart';
import '../model/home_data.dart';

class ApplicationBloc {
  HomeData homeData = HomeData();

  Cart cart = Cart();

  ApplicationBloc() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    final List<dynamic> marketCampaignsJson = await getMarketCampaign();
    final List<MarketCampaign> marketCampaigns = marketCampaignsJson
        .map((jsonCampaign) => MarketCampaign.fromJson(jsonCampaign))
        .toList();

    homeData.marketCampaigns.value = marketCampaigns;
    homeData.womenClothes.value = generateMockClothesItems(20, "女裝");
    homeData.menClothes.value = generateMockClothesItems(20, "男裝");
    homeData.accessories.value = generateMockClothesItems(20, "配件");
  }

  void addClothesItem(ClothesItem clothesItem) {
    cart.addClothesItem(clothesItem);
  }

  void removeClothesItem(ClothesItem clothesItem) {
    cart.removeClothesItem(clothesItem);
  }

  void clearClothesItems() {
    cart.clearClothesItems();
  }
}
