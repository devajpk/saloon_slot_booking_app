class ShopModel {
  final int barberId;
  final String shopName;
  final String shopAddress;
  final String shopImageUrl;
  final String barberName;
  final String phoneNumber;
  final String? licenseNumber;
  final double avgRating;
  final int totalReviews;
  final int? availableSlotsCount;
  final String? nextAvailableSlot;
  final String? nextAvailableTime;
  final bool shopStatus;

  ShopModel({
    required this.barberId,
    required this.shopName,
    required this.shopAddress,
    required this.shopImageUrl,
    required this.barberName,
    required this.phoneNumber,
    this.licenseNumber,
    required this.avgRating,
    required this.totalReviews,
    this.availableSlotsCount,
    this.nextAvailableSlot,
    this.nextAvailableTime,
    required this.shopStatus,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    return ShopModel(
      barberId: json['barber_id'] ?? 0,
      shopName: json['shop_name'] ?? '',
      shopAddress: json['shop_address'] ?? '',
      shopImageUrl: json['shop_image_url'] ?? '',
      barberName: json['barber_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      licenseNumber: json['license_number'],
      avgRating: (json['avg_rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      availableSlotsCount: json['available_slots_count'],
      nextAvailableSlot: json['next_available_slot'],
      nextAvailableTime: json['next_available_time'],
      shopStatus: json['shop_status'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barber_id': barberId,
      'shop_name': shopName,
      'shop_address': shopAddress,
      'shop_image_url': shopImageUrl,
      'barber_name': barberName,
      'phone_number': phoneNumber,
      'license_number': licenseNumber,
      'avg_rating': avgRating,
      'total_reviews': totalReviews,
      'available_slots_count': availableSlotsCount,
      'next_available_slot': nextAvailableSlot,
      'next_available_time': nextAvailableTime,
      'shop_status': shopStatus,
    };
  }
}
