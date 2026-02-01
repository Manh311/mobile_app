import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/456_tournament.dart';

class TournamentProvider456 with ChangeNotifier {
  final ApiService _api = ApiService();
  List<Tournament456> _tournaments = [];
  bool _isLoading = false;

  List<Tournament456> get tournaments => _tournaments;
  bool get isLoading => _isLoading;

  // Lấy danh sách giải đấu (GET /api/tournaments)
  Future<void> fetchTournaments() async {
    _isLoading = true;
    notifyListeners();
    try {
      final res = await _api.client.get('/tournaments');
      if (res.statusCode == 200) {
        _tournaments = (res.data as List).map((e) => Tournament456.fromJson(e)).toList();
      }
    } catch (e) {
      debugPrint("Lỗi tải giải đấu: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  // Tham gia giải (POST /api/tournaments/{id}/join)
  Future<bool> joinTournament(String id) async {
    try {
      final res = await _api.client.post('/tournaments/$id/join');
      return res.statusCode == 200; // API sẽ tự check ví và trừ Entry Fee 
    } catch (e) {
      return false;
    }
  }
}