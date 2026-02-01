import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/456_member.dart';


class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  Member456? _user;
  bool _isLoading = false;

  Member456? get user => _user;
  bool get isLoading => _isLoading;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // POST /api/auth/login trả về JWT + User Info [cite: 125]
      final response = await _apiService.client.post('/auth/login', data: {
        'username': username,
        'password': password,
      });

      if (response.statusCode == 200) {
        _user = Member456.fromJson(response.data['userInfo']);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint("Login error: $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }
  
  Future<void> logout() async {
    // Clear user data
    _user = null;
    
    // Clear any stored tokens/preferences
    // Example: await SharedPreferences.getInstance().then((prefs) => prefs.clear());
    notifyListeners();
  }
    void updateData() {
    notifyListeners();
  }
}



