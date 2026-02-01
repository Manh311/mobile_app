import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/456_booking.dart';


class BookingProvider456 with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Booking456> _bookings = [];
  bool _isLoading = false;

  List<Booking456> get bookings => _bookings;
  bool get isLoading => _isLoading;

  // Lấy lịch đặt sân theo khoảng ngày [cite: 136]
  Future<void> fetchBookings(DateTime start, DateTime end) async {
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _apiService.client.get(
        '/bookings/calendar',
        queryParameters: {
          'from': start.toIso8601String(),
          'to': end.toIso8601String(),
        },
      );
      if (response.statusCode == 200) {
        _bookings = (response.data as List)
            .map((json) => Booking456.fromJson(json))
            .toList();
      }
    } catch (e) {
      debugPrint("Lỗi tải lịch: $e");
    }
    _isLoading = false;
    notifyListeners();
  }

  // Phương thức đặt sân đơn lẻ [cite: 137]
  Future<bool> createBooking(String courtId, DateTime start, DateTime end) async {
    try {
      final response = await _apiService.client.post('/bookings', data: {
        'courtId': courtId,
        'startTime': start.toIso8601String(),
        'endTime': end.toIso8601String(),
      });
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}