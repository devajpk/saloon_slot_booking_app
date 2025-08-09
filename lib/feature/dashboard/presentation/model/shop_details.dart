class SlotModel {
  final int slotId;
  final String slotDate;
  final String startTime;
  final String endTime;

  SlotModel({
    required this.slotId,
    required this.slotDate,
    required this.startTime,
    required this.endTime,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      slotId: json['slot_id'],
      slotDate: json['slot_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'slot_id': slotId,
      'slot_date': slotDate,
      'start_time': startTime,
      'end_time': endTime,
    };
  }
}

class ShopDetails {
  final int barberId;
  final String shopName;
  final String shopAddress;
  final String shopImageUrl;
  final String barberName;
  final String phoneNumber;
  final String email;
  final String? licenseNumber;
  final double avgRating;
  final int totalReviews;
  final List<dynamic> recentReviews;
  final List<SlotModel> availableSlots;
  final Map<String, String> businessHours;
  final DateTime memberSince;
  final bool shopStatus;

  ShopDetails({
    required this.barberId,
    required this.shopName,
    required this.shopAddress,
    required this.shopImageUrl,
    required this.barberName,
    required this.phoneNumber,
    required this.email,
    required this.licenseNumber,
    required this.avgRating,
    required this.totalReviews,
    required this.recentReviews,
    required this.availableSlots,
    required this.businessHours,
    required this.memberSince,
    required this.shopStatus,
  });

  factory ShopDetails.fromJson(Map<String, dynamic> json) {
    return ShopDetails(
      barberId: json['barber_id'],
      shopName: json['shop_name'],
      shopAddress: json['shop_address'],
      shopImageUrl: json['shop_image_url'],
      barberName: json['barber_name'],
      phoneNumber: json['phone_number'],
      email: json['email'],
      licenseNumber: json['license_number'],
      avgRating: (json['avg_rating'] ?? 0).toDouble(),
      totalReviews: json['total_reviews'] ?? 0,
      recentReviews: json['recent_reviews'] ?? [],
      availableSlots: (json['available_slots'] as List)
          .map((e) => SlotModel.fromJson(e))
          .toList(),
      businessHours: Map<String, String>.from(json['business_hours'] ?? {}),
      memberSince: DateTime.parse(json['member_since']),
      shopStatus: json['shop_status'],
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
      'email': email,
      'license_number': licenseNumber,
      'avg_rating': avgRating,
      'total_reviews': totalReviews,
      'recent_reviews': recentReviews,
      'available_slots': availableSlots.map((e) => e.toJson()).toList(),
      'business_hours': businessHours,
      'member_since': memberSince.toIso8601String(),
      'shop_status': shopStatus,
    };
  }
}
