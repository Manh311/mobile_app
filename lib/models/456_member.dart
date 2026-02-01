import '456_enums.dart';

class Member456 {
  final String id;
  final String fullName;
  final DateTime joinDate;
  final double rankLevel; // Rank DUPR
  final bool isActive;
  final double walletBalance; // [cite: 57]
  final MemberTier456 tier; // [cite: 58]
  final double totalSpent; // [cite: 59]
  final String? avatarUrl; // [cite: 60]

  Member456({
    required this.id, required this.fullName, required this.joinDate,
    required this.rankLevel, required this.isActive,
    required this.walletBalance, required this.tier, required this.totalSpent,
    this.avatarUrl,
  });

  factory Member456.fromJson(Map<String, dynamic> json) => Member456(
    id: json['id'],
    fullName: json['fullName'],
    joinDate: DateTime.parse(json['joinDate']),
    rankLevel: (json['rankLevel'] ?? 0.0).toDouble(),
    isActive: json['isActive'] ?? true,
    walletBalance: (json['walletBalance'] ?? 0.0).toDouble(),
    tier: MemberTier456.values.firstWhere((e) => e.name == json['tier']),
    totalSpent: (json['totalSpent'] ?? 0.0).toDouble(),
    avatarUrl: json['avatarUrl'],
  );
}