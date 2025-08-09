class MyBookingModel {
  final int bookingId;
  final int slotId;
  final String status;
  final DateTime bookedAt;
  final String slotDate;
  final String startTime;
  final String endTime;
  final int barberId;
  final String barberName;
  final String shopName;
  final String shopAddress;
  final String shopImageUrl;
  final String barberPhone;
  final String specialRequests;
  final bool canModify;
  final bool isPast;

  MyBookingModel({
    required this.bookingId,
    required this.slotId,
    required this.status,
    required this.bookedAt,
    required this.slotDate,
    required this.startTime,
    required this.endTime,
    required this.barberId,
    required this.barberName,
    required this.shopName,
    required this.shopAddress,
    required this.shopImageUrl,
    required this.barberPhone,
    required this.specialRequests,
    required this.canModify,
    required this.isPast,
  });

  factory MyBookingModel.fromJson(Map<String, dynamic> json) {
    return MyBookingModel(
      bookingId: json['booking_id'] ?? 0,
      slotId: json['slot_id'] ?? 0,
      status: json['status'] ?? '',
      bookedAt: DateTime.parse(json['booked_at']),
      slotDate: json['slot_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      barberId: json['barber_id'] ?? 0,
      barberName: json['barber_name'] ?? '',
      shopName: json['shop_name'] ?? '',
      shopAddress: json['shop_address'] ?? '',
      shopImageUrl: json['shop_image_url'] ?? '',
      barberPhone: json['barber_phone'] ?? '',
      specialRequests: json['special_requests'] ?? '',
      canModify: json['can_modify'] ?? false,
      isPast: json['is_past'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'slot_id': slotId,
      'status': status,
      'booked_at': bookedAt.toIso8601String(),
      'slot_date': slotDate,
      'start_time': startTime,
      'end_time': endTime,
      'barber_id': barberId,
      'barber_name': barberName,
      'shop_name': shopName,
      'shop_address': shopAddress,
      'shop_image_url': shopImageUrl,
      'barber_phone': barberPhone,
      'special_requests': specialRequests,
      'can_modify': canModify,
      'is_past': isPast,
    };
  }
}
