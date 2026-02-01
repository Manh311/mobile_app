import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/auth_provider.dart';
import 'booking_calendar_screen.dart';
import 'tournament_list_screen.dart';
import 'wallet_screen.dart';
import 'dashboard_screen.dart';
import 'profile_screen.dart';

class HomeScreenHeader extends StatelessWidget {
  const HomeScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Sử dụng Consumer để lắng nghe thay đổi số dư ví real-time
    return Consumer<AuthProvider>(
      builder: (context, auth, child) {
        final user = auth.user;
        final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: user?.avatarUrl != null 
                    ? NetworkImage(user!.avatarUrl!) 
                    : const AssetImage('assets/default_avatar.png') as ImageProvider,
              ),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user?.fullName ?? 'Hội viên PCM', style: const TextStyle(fontSize: 16)),
                Text(
                  'Số dư: ${currencyFormat.format(user?.walletBalance ?? 0)}',
                  style: const TextStyle(fontSize: 14, color: Colors.greenAccent),
                ),
              ],
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
            ],
          ),
        );
      },
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách các màn hình (Dashboard, Lịch, Giải đấu, Ví, Cá nhân) 
  // Đảm bảo danh sách này có đủ 5 màn hình tương ứng với 5 Icon bên dưới
final List<Widget> _pages = [
  const DashboardScreen(), // Index 0: Trang chủ
  const BookingCalendarScreen(), // Index 1: Đặt sân
  const TournamentListScreen(), // Index 2: Giải đấu
  const WalletScreen(), // Index 3: Ví (Bấm vào đây sẽ hết lỗi RangeError)
  const ProfileScreen(), // Index 4: Cá nhân (Bấm vào đây sẽ hết lỗi RangeError)
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Trang chủ'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month), label: 'Đặt sân'),
          BottomNavigationBarItem(icon: Icon(Icons.emoji_events), label: 'Giải đấu'), // Mục truy cập giải đấu 
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'Ví'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Cá nhân'),
        ],
      ),
    );
  }
}