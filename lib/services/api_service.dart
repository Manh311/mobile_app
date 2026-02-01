import 'package:dio/dio.dart'; // [cite: 152]
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // [cite: 152]
import 'dart:convert'; // [cite: 156]
import 'package:http/http.dart' as http; // [cite: 157]

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:5000/api', // 
    connectTimeout: const Duration(seconds: 10),
  ));

  final _storage = const FlutterSecureStorage();

  ApiService() {
    client.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await _storage.read(key: 'jwt_token');
        if (token != null) options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
  }

  Dio get client => _dio;

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    try {
      // Replace with your actual API base URL
      final url = Uri.parse('https://your-api-url.com$endpoint');
      
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<dynamic> postFormData(String endpoint, FormData formData) async {
    try {
      final response = await _dio.post(endpoint, data: formData);
      return response.data;
    } catch (e) {
      throw Exception('Failed to post form data: $e');
    }
  }

  Future<dynamic> get(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
}