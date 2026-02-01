import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import '../providers/booking_provider.dart';
import '../providers/auth_provider.dart';

class BookingCalendarScreen extends StatefulWidget {
  const BookingCalendarScreen({super.key});

  @override
  State<BookingCalendarScreen> createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final bookingProvider = context.watch<BookingProvider456>();
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Lịch đặt sân PCM')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 30)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              // Tải dữ liệu booking cho ngày được chọn
            },
            calendarStyle: const CalendarStyle(
              todayDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
              selectedDecoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
            ),
          ),
          const Divider(),
          Expanded(
            child: _buildTimeSlots(bookingProvider, authProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSlots(BookingProvider456 provider, AuthProvider auth) {
    // Logic hiển thị danh sách các khung giờ (Slots)
    // Mỗi slot kiểm tra trạng thái:
    // - Nếu b.memberId == auth.user.id -> Màu xanh (Sân của mình) 
    // - Nếu có booking khác -> Màu đỏ (Đã đặt) 
    // - Ngược lại -> Màu xám (Trống) 
    return ListView.builder(
      itemCount: 14, // Giả sử từ 6:00 đến 20:00
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('${6 + index}:00 - ${7 + index}:00'),
          trailing: ElevatedButton(
            onPressed: () => _showBookingConfirm(context), // Mở BottomSheet đặt sân [cite: 168]
            child: const Text('Đặt ngay'),
          ),
        );
      },
    );
  }
  
  void _showBookingConfirm(BuildContext context) {
    // Hiển thị BottomSheet xác nhận và gọi API [cite: 168]
  }
}