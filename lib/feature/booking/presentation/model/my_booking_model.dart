class BookingModel {
  final int? bookingId;
  final int? slotId;
  final String? status;
  final DateTime? bookedAt;
  final String? slotDate;
  final String? startTime;
  final String? endTime;
  final int? customerId;
  final String? customerName;
  final String? customerPhone;
  final String? specialRequests;
  final bool? isPast;
  final bool? canModify;

  BookingModel({
    this.bookingId,
    this.slotId,
    this.status,
    this.bookedAt,
    this.slotDate,
    this.startTime,
    this.endTime,
    this.customerId,
    this.customerName,
    this.customerPhone,
    this.specialRequests,
    this.isPast,
    this.canModify,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      bookingId: json['booking_id'],
      slotId: json['slot_id'],
      status: json['status'],
      bookedAt: json['booked_at'] != null
          ? DateTime.tryParse(json['booked_at'])
          : null,
      slotDate: json['slot_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      customerId: json['customer_id'],
      customerName: json['customer_name'],
      customerPhone: json['customer_phone'],
      specialRequests: json['special_requests'],
      isPast: json['is_past'],
      canModify: json['can_modify'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'booking_id': bookingId,
      'slot_id': slotId,
      'status': status,
      'booked_at': bookedAt?.toIso8601String(),
      'slot_date': slotDate,
      'start_time': startTime,
      'end_time': endTime,
      'customer_id': customerId,
      'customer_name': customerName,
      'customer_phone': customerPhone,
      'special_requests': specialRequests,
      'is_past': isPast,
      'can_modify': canModify,
    };
  }

  /// Named constructor to create an "empty" BookingModel with all fields null/default
  factory BookingModel.empty() {
    return BookingModel(
      bookingId: null,
      slotId: null,
      status: null,
      bookedAt: null,
      slotDate: null,
      startTime: null,
      endTime: null,
      customerId: null,
      customerName: null,
      customerPhone: null,
      specialRequests: null,
      isPast: null,
      canModify: null,
    );
  }
}
