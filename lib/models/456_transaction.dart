import '456_enums.dart';

class WalletTransaction456 {
  final String id;
  final String memberId;
  final double amount; // [cite: 63]
  final TransactionType456 type; // [cite: 64]
  final TransactionStatus456 status; // [cite: 66]
  final String? relatedId; // ID của Booking hoặc Tournament liên quan [cite: 67]
  final String description;
  final DateTime createdDate;

  WalletTransaction456({
    required this.id, required this.memberId, required this.amount,
    required this.type, required this.status, this.relatedId,
    required this.description, required this.createdDate,
  });
}