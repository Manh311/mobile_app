import '456_enums.dart';

class Tournament456 {
  final String id;
  final String name;
  final DateTime startDate;
  final TournamentFormat456 format; // RoundRobin, Knockout, Hybrid [cite: 93]
  final double entryFee; // [cite: 94]
  final double prizePool; // [cite: 95]
  final TournamentStatus456 status; // Open, Ongoing, Finished [cite: 96]

  Tournament456({
    required this.id, required this.name, required this.startDate,
    required this.format, required this.entryFee, required this.prizePool,
    required this.status,
  });

  factory Tournament456.fromJson(Map<String, dynamic> json) => Tournament456(
    id: json['id'],
    name: json['name'],
    startDate: DateTime.parse(json['startDate']),
    format: TournamentFormat456.values.firstWhere((e) => e.name == json['format']),
    entryFee: json['entryFee'].toDouble(),
    prizePool: json['prizePool'].toDouble(),
    status: TournamentStatus456.values.firstWhere((e) => e.name == json['status']),
  );
}