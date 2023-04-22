import 'dart:async';

import 'package:flutter_minjing_stylish/model/clothes.dart';
import 'package:flutter_minjing_stylish/model/campaign.dart';
import 'package:flutter_minjing_stylish/network/api_service.dart';

import '../model/cart.dart';
import '../model/home_data.dart';
import '../model/hot.dart';

class ApplicationBloc {
  HomeData homeData = HomeData();

  Cart cart = Cart();

  ApplicationBloc() {
    _fetchData();
  }

  Future<void> _fetchData() async {
    final List<dynamic> campaignsJson = await getMarketCampaign();
    final List<Campaign> campaigns = campaignsJson
        .map((jsonCampaign) => Campaign.fromJson(jsonCampaign))
        .toList();

    homeData.campaigns.value = campaigns;

    final List<dynamic> hotsJson = await getHots();
    final List<Hot> hots = hotsJson
        .map((jsonHot) => Hot.fromJson(jsonHot))
        .toList();

    homeData.hots.value = hots;

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
