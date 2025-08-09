class SlotModel {
  final int id;
  final String slotDate;
  final String startTime;
  final String endTime;
  final bool isBooked;
  final int? bookedBy;
  final int barberId;

  SlotModel({
    required this.id,
    required this.slotDate,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    this.bookedBy,
    required this.barberId,
  });

  factory SlotModel.fromJson(Map<String, dynamic> json) {
    return SlotModel(
      id: json['id'],
      slotDate: json['slot_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      isBooked: json['is_booked'],
      bookedBy: json['booked_by'],
      barberId: json['barber_id'],
    );
  }
}
