class MySloteModel {
  final int id;
  final int barberId;
  final String slotDate;
  final DateTime slotTime;
  final String startTime;
  final String endTime;
  final bool isBooked;
  final int? bookedBy;
  final DateTime createdAt;

  MySloteModel({
    required this.id,
    required this.barberId,
    required this.slotDate,
    required this.slotTime,
    required this.startTime,
    required this.endTime,
    required this.isBooked,
    required this.bookedBy,
    required this.createdAt,
  });

  factory MySloteModel.fromJson(Map<String, dynamic> json) {
    return MySloteModel(
      id: json['id'],
      barberId: json['barber_id'],
      slotDate: json['slot_date'],
      slotTime: DateTime.parse(json['slot_time']),
      startTime: json['start_time'],
      endTime: json['end_time'],
      isBooked: json['is_booked'],
      bookedBy: json['booked_by'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'barber_id': barberId,
      'slot_date': slotDate,
      'slot_time': slotTime.toIso8601String(),
      'start_time': startTime,
      'end_time': endTime,
      'is_booked': isBooked,
      'booked_by': bookedBy,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
