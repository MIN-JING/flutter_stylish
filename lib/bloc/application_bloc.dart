import 'dart:async';

import 'package:flutter_minjing_stylish/model/campaign.dart';
import 'package:flutter_minjing_stylish/network/api_service.dart';

import '../model/cart.dart';
import '../model/home_data.dart';
import '../model/hot.dart';
import '../model/product.dart';
import '../network/api_constant.dart';

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
    
    final List<dynamic> productsWomenJson = await getProducts(ApiConstant.women);
    final List<Product> productsWomen = productsWomenJson
        .map((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
    homeData.productsWomen.value = productsWomen;

    final List<dynamic> productsMenJson = await getProducts(ApiConstant.men);
    final List<Product> productsMen = productsMenJson
        .map((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
    homeData.productsMen.value = productsMen;

    final List<dynamic> productsAccessoriesJson = await getProducts(ApiConstant.accessories);
    final List<Product> productsAccessories = productsAccessoriesJson
        .map((jsonProduct) => Product.fromJson(jsonProduct))
        .toList();
    homeData.productsAccessories.value = productsAccessories;
  }

  void addProduct(Product product) {
    cart.addProduct(product);
  }

  void removeProduct(Product product) {
    cart.removeProduct(product);
  }

  void clearClothesItems() {
    cart.clearProducts();
  }
}
