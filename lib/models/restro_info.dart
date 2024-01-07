class HotelInfo {
  final int id;
  final String name;
  final String tags;
  final double rating;
  final int discount;
  final String primaryImage;
  final double distance;

  HotelInfo({
    required this.id,
    required this.name,
    required this.tags,
    required this.rating,
    required this.discount,
    required this.primaryImage,
    required this.distance,
  });

  factory HotelInfo.fromJson(Map<String, dynamic> json) {
    return HotelInfo(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      tags: json['tags'] ?? '',
      rating: (json['rating'] ?? 0.0).toDouble(),
      discount: json['discount'] ?? 0,
      primaryImage: json['primary_image'] ?? '',
      distance: (json['distance'] ?? 0.0).toDouble(),
    );
  }

  @override
  String toString() {
    return 'HotelInfo{id: $id, name: $name, tags: $tags, rating: $rating, '
        'discount: $discount, primaryImage: $primaryImage, distance: $distance}';
  }
}
