class ResponseMarketCampaign {
  final List<MarketCampaign> marketCampaign;

  ResponseMarketCampaign({
    required this.marketCampaign,
  });

  factory ResponseMarketCampaign.fromJson(Map<String, dynamic> json) {
    return ResponseMarketCampaign(
      marketCampaign: (json['data'] as List<dynamic>)
          .map((e) => MarketCampaign.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class MarketCampaign {
  final int id;
  final int productId;
  final String picture;
  final String story;

  MarketCampaign({
    required this.id,
    required this.productId,
    required this.picture,
    required this.story,
  });

  factory MarketCampaign.fromJson(Map<String, dynamic> json) {
    return MarketCampaign(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      picture: json['picture'] as String,
      story: json['story'] as String,
    );
  }
}

// {
//   "data": [
//     {
//       "id": 1,
//       "product_id": 201807242228,
//       "picture": "https://api.appworks-school.tw/assets/201807242228/keyvisual.jpg",
//       "story": "於是\r\n我也想要給你\r\n一個那麼美好的自己。\r\n不朽《與自己和好如初》"
//     },
//     {
//       "id": 2,
//       "product_id": 201807242222,
//       "picture": "https://api.appworks-school.tw/assets/201807242222/keyvisual.jpg",
//       "story": "永遠\r\n展現自信與專業\r\n無法抵擋的男人魅力。\r\n復古《再一次經典》"
//     },
//     {
//       "id": 3,
//       "product_id": 201807202140,
//       "picture": "https://api.appworks-school.tw/assets/201807202140/keyvisual.jpg",
//       "story": "瞬間\r\n在城市的角落\r\n找到失落多時的記憶。\r\n印象《都會故事集》"
//     }
//   ]
// }