import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_constant.dart';

final dio = Dio();

Future<List<dynamic>> getMarketCampaign() async {
  try {
    final response = await dio.get(ApiConstant.campaigns);
    if (kDebugMode) {
      print(response);
    }
    return response.data['data'];
  } catch (e) {
    if (e is DioError) {
      if (kDebugMode) {
        print('Dio error occurred: ${e.error}');
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error occurred: $e');
      }
    }
    return [];
  }
}

Future<List<dynamic>> getHots() async {
  try {
    final response = await dio.get(ApiConstant.hots);
    if (kDebugMode) {
      print(response);
    }
    return response.data['data'];
  } catch (e) {
    if (e is DioError) {
      if (kDebugMode) {
        print('Dio error occurred: ${e.error}');
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error occurred: $e');
      }
    }
    return [];
  }
}

Future<List<dynamic>> getProducts(String category) async {
  try {
    final response = await dio.get(ApiConstant.products + category);
    if (kDebugMode) {
      print(response);
    }
    return response.data['data'];
  } catch (e) {
    if (e is DioError) {
      if (kDebugMode) {
        print('Dio error occurred: ${e.error}');
      }
    } else {
      if (kDebugMode) {
        print('Unexpected error occurred: $e');
      }
    }
    return [];
  }
}