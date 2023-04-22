
class ResponseCampaigns {
  final List<Campaign> marketCampaign;

  ResponseCampaigns({
    required this.marketCampaign,
  });

  factory ResponseCampaigns.fromJson(Map<String, dynamic> json) {
    return ResponseCampaigns(
      marketCampaign: (json['data'] as List<dynamic>)
          .map((e) => Campaign.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Campaign {
  final int id;
  final int productId;
  final String picture;
  final String story;

  Campaign({
    required this.id,
    required this.productId,
    required this.picture,
    required this.story,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'] as int,
      productId: json['product_id'] as int,
      picture: json['picture'] as String,
      story: json['story'] as String,
    );
  }
}
