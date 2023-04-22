import 'package:flutter/cupertino.dart';

import 'clothes.dart';
import 'market_campaign.dart';

class HomeData {
  ValueNotifier<List<MarketCampaign>> marketCampaigns =
  ValueNotifier<List<MarketCampaign>>([]);

  ValueNotifier<List<ClothesItem>> womenClothes =
  ValueNotifier<List<ClothesItem>>([]);

  ValueNotifier<List<ClothesItem>> menClothes =
  ValueNotifier<List<ClothesItem>>([]);

  ValueNotifier<List<ClothesItem>> accessories =
  ValueNotifier<List<ClothesItem>>([]);
}
