import '456_enums.dart';

class Booking456 {
  final String id;
  final String courtId;
  final String memberId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice; // [cite: 83]
  final bool isRecurring; // [cite: 86]
  final String? recurrenceRule; // VD: Weekly; Tue, Thu [cite: 87]
  final BookingStatus456 status; // [cite: 89]

  Booking456({
    required this.id, required this.courtId, required this.memberId,
    required this.startTime, required this.endTime, required this.totalPrice,
    required this.isRecurring, this.recurrenceRule, required this.status,
  });

  factory Booking456.fromJson(Map<String, dynamic> json) => Booking456(
    id: json['id'],
    courtId: json['courtId'],
    memberId: json['memberId'],
    startTime: DateTime.parse(json['startTime']),
    endTime: DateTime.parse(json['endTime']),
    totalPrice: json['totalPrice'].toDouble(),
    isRecurring: json['isRecurring'],
    recurrenceRule: json['recurrenceRule'],
    status: BookingStatus456.values.firstWhere((e) => e.name == json['status']),
  );
}