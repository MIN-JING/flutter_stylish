class ApiConstant {
  // add a private constructor to prevent this class being instantiated
  // e.g. invoke `ApiConstant()` accidentally
  ApiConstant._();

  static const String host = 'https://api.appworks-school.tw';
  static const String apiVersion = '1.0';
  static const String basePath = '$host/api/$apiVersion';
  static const String campaigns = '$basePath/marketing/campaigns';
  static const String hots = '$basePath/marketing/hots';
  static const String products = '$basePath/products/';
  static const String all = 'all';
  static const String women = 'women';
  static const String men = 'men';
  static const String accessories = 'accessories';
}