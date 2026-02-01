import 'package:flutter/material.dart';

import 'home_screen.dart'; // Đảm bảo bạn đã tạo file này


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Đăng nhập PCM')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
             context, 
             MaterialPageRoute(builder: (context) => const HomeScreen()), // Đổi TrangChu thành HomeScreen
            );
          },
          child: const Text('Đăng nhập'),
        ),
      ),
    );
  }
}

