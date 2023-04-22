import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

const String host = 'https://api.appworks-school.tw';
const String apiVersion = '1.0';
const String basePath = '$host/api/$apiVersion';
const String marketCampaign = '$basePath/marketing/campaigns';

final dio = Dio();

Future<List<dynamic>> getMarketCampaign() async {
  try {
    final response = await dio.get(marketCampaign);
    print(response);
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
