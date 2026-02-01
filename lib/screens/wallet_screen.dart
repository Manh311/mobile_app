import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Sửa lỗi ở ảnh image_92934d.png
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _evidenceImage;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() => _evidenceImage = image);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(title: const Text('Ví của tôi')),
      body: Column(
        children: [
          // Hiển thị số dư
          Container(
            padding: const EdgeInsets.all(30),
            color: Colors.green.shade50,
            child: Center(
              child: Column(
                children: [
                  const Text('Số dư hiện tại'),
                  Text('${user?.walletBalance ?? 0} đ', style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.green)),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => _showDepositDialog(context),
            icon: const Icon(Icons.add),
            label: const Text('Nạp tiền vào ví'),
          ),

          const Expanded(
            child: Center(child: Text('Chưa có lịch sử giao dịch')),
          )
        ],
      ),
    );
  }

  void _showDepositDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Gửi yêu cầu nạp tiền'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const TextField(decoration: InputDecoration(labelText: 'Số tiền muốn nạp')),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  final img = await _picker.pickImage(source: ImageSource.gallery);
                  setDialogState(() => _evidenceImage = img);
                },
                child: const Text('Chọn ảnh chuyển khoản'),
              ),
              if (_evidenceImage != null) 
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Đã chọn: ${_evidenceImage!.name}', style: const TextStyle(fontSize: 10)),
                ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Hủy')),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Gửi xác nhận')),
          ],
        ),
      ),
    );
  }
}