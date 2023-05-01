import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

Future<List<LatLng>> getDirections(LatLng start, LatLng end) async {
  if (kDebugMode) {
    print('start.latitude: ${start.latitude}');
    print('start.longitude: ${start.longitude}');
    print('end.latitude: ${end.latitude}');
    print('end.longitude: ${end.longitude}');
  }


  final url =
      "https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=${ApiConstant.googleMapKey}";

  try {
    final response = await dio.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = response.data;
      final points = jsonResponse['routes'][0]['overview_polyline']['points'];
      final polylinePoints = PolylinePoints();
      final pointLatLngList = polylinePoints.decodePolyline(points);

      if (kDebugMode) {
        print('API response: ${jsonResponse.toString()}');
        print('getDirections: ${response.data.toString()}');
      }

      if (jsonResponse['routes'].isEmpty) {
        throw Exception('No route found');
      }

      // Convert the list of PointLatLng objects to a list of LatLng objects
      return pointLatLngList.map((point) => LatLng(point.latitude, point.longitude)).toList();
    } else {
      if (kDebugMode) {
        print('API response: ${response.data.toString()}');
      }
      throw Exception('Error getting directions');
    }
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