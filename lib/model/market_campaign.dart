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
