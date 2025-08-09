class BookingStatusUpdate {
  final String message;
  final int bookingId;
  final String oldStatus;
  final String newStatus;
  final DateTime updatedAt;

  BookingStatusUpdate({
    required this.message,
    required this.bookingId,
    required this.oldStatus,
    required this.newStatus,
    required this.updatedAt,
  });

  factory BookingStatusUpdate.fromJson(Map<String, dynamic> json) {
    return BookingStatusUpdate(
      message: json['message'],
      bookingId: json['booking_id'],
      oldStatus: json['old_status'],
      newStatus: json['new_status'],
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'booking_id': bookingId,
      'old_status': oldStatus,
      'new_status': newStatus,
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
