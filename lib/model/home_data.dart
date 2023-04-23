import 'package:flutter/cupertino.dart';
import 'package:flutter_minjing_stylish/model/product.dart';

import 'clothes.dart';
import 'campaign.dart';
import 'hot.dart';

class HomeData {
  ValueNotifier<List<Campaign>> campaigns = ValueNotifier<List<Campaign>>([]);

  ValueNotifier<List<Hot>> hots = ValueNotifier<List<Hot>>([]);

  ValueNotifier<List<Product>> productsWomen = ValueNotifier<List<Product>>([]);

  ValueNotifier<List<Product>> productsMen = ValueNotifier<List<Product>>([]);

  ValueNotifier<List<Product>> productsAccessories = ValueNotifier<List<Product>>([]);
}
