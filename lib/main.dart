import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Import các Provider (Bộ não xử lý logic)
import 'providers/auth_provider.dart';
import 'providers/booking_provider.dart';
import 'providers/tournament_provider.dart'; // Cần thiết để truy cập giải đấu
import 'screens/login_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        // SỬA TẠI ĐÂY: Dùng BookingProvider456 thay vì Model Booking456
        ChangeNotifierProvider(create: (_) => BookingProvider456()), 
        // THÊM: Provider để quản lý giải đấu
        ChangeNotifierProvider(create: (_) => TournamentProvider456()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const LoginScreen(), 
    );
  }
}