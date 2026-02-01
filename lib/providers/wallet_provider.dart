import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../services/api_service.dart';

class WalletProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  List<dynamic> _transactions = [];

  bool get isLoading => _isLoading;
  List<dynamic> get transactions => _transactions;

  // POST /api/wallet/deposit: Nạp tiền kèm ảnh
  Future<void> fetchTransactions() async {
    final res = await _apiService.client.get('/wallet/transactions');
    _transactions = res.data;
    notifyListeners();
  }

  // GET /api/wallet/transactions: Lịch sử ví
  Future<bool> deposit(double amount, File image) async {
    FormData data = FormData.fromMap({
      "amount": amount,
      "evidenceImage": await MultipartFile.fromFile(image.path),
    });
    final res = await _apiService.client.post('/wallet/deposit', data: data);
    return res.statusCode == 200;
  }
}