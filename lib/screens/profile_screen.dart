import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart'; // Đảm bảo đã thêm fl_chart vào pubspec.yaml
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin user từ bộ não AuthProvider
    final auth = context.watch<AuthProvider>();
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Hồ sơ cá nhân')),
      body: user == null 
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // 1. Ảnh đại diện & Tên
                const CircleAvatar(radius: 50, backgroundImage: NetworkImage('https://via.placeholder.com/150')),
                const SizedBox(height: 12),
                Text(user.fullName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                
                // 2. Hạng thành viên (Tier)
                const SizedBox(height: 8),
                _buildTierBadge(user.tier.toString()), // Đảm bảo dùng toString() nếu là enum
                
                const SizedBox(height: 24),
                
                // 3. Biểu đồ Rank DUPR
                const Align(alignment: Alignment.centerLeft, child: Text('Tiến trình Rank', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: LineChart(LineChartData(
                    lineBarsData: [LineChartBarData(spots: [const FlSpot(0, 3.0), const FlSpot(1, 3.2), const FlSpot(2, 3.5)], isCurved: true, color: Colors.orange)],
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(show: false),
                  )),
                ),

                const SizedBox(height: 30),
                
                // 4. Nút Đăng xuất
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade50, foregroundColor: Colors.red),
                  onPressed: () => auth.logout(), // Cần viết hàm logout trong AuthProvider
                  child: const Text('Đăng xuất'),
                ),
              ],
            ),
          ),
    );
  }

  Widget _buildTierBadge(String tier) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(color: Colors.orange.shade100, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange)),
      child: Text(tier, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
    );
  }
}