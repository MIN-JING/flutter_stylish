import 'package:flutter/cupertino.dart';

import 'clothes.dart';
import 'campaign.dart';
import 'hot.dart';

class HomeData {
  ValueNotifier<List<Campaign>> campaigns = ValueNotifier<List<Campaign>>([]);

  ValueNotifier<List<Hot>> hots = ValueNotifier<List<Hot>>([]);

  ValueNotifier<List<ClothesItem>> womenClothes = ValueNotifier<List<ClothesItem>>([]);

  ValueNotifier<List<ClothesItem>> menClothes = ValueNotifier<List<ClothesItem>>([]);

  ValueNotifier<List<ClothesItem>> accessories = ValueNotifier<List<ClothesItem>>([]);
}
