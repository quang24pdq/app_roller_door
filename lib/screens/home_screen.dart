import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_app/Page/Bluetooth_Page';

import 'package:my_app/screens/login_screen.dart';
import 'package:my_app/screens/device_screen.dart';
import 'package:my_app/screens/usage_history_screen.dart';
import '../Page/Change_Password_Page.dart';
import '../Page/Set_Timer_Page.dart';
import '../Page/Scan_Qr_Page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String deviceStatus = 'Trạng thái: Trực tuyến';

  FlutterBlue flutterBlue = FlutterBlue.instance;

  void _resetScreen() {
    setState(() {
      deviceStatus = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AST Remote'),
        backgroundColor: const Color(0xFF007AFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetScreen,
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              const Text(
                'SR3651274\nCửa Chính Nhà',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF007AFF),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deviceStatus,
                style: TextStyle(
                  color: Colors.green[800],
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 32),
              _buildRemoteControl(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFE53935),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Kết nối với'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.bluetooth, color: Color(0xFF007AFF)),
                      title: const Text('Bluetooth'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BluetoothPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.wifi, color: Color(0xFF007AFF)),
                      title: const Text('Wi-Fi'),
                      onTap: () {
                        Navigator.pop(context);
                        // Thêm mã kết nối Wi-Fi ở đây
                      },
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Hủy'),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildRemoteControl() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControlButton(Icons.arrow_upward, 'Lên'),
                  const SizedBox(width: 16),
                  _buildControlButton(Icons.arrow_downward, 'Xuống'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildControlButton(Icons.lock, 'Khóa'),
                  const SizedBox(width: 16),
                  _buildControlButton(Icons.lock_open, 'Mở'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label) {
    return Container(
      width: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color(0xFF007AFF),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.3),
        ),
        onPressed: () {
          // Chức năng của nút
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 28),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF007AFF),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            child: UserAccountsDrawerHeader(
              accountName: const Text('Tên Người Dùng', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              accountEmail: const Text('user@example.com', style: TextStyle(color: Colors.white)),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF007AFF)),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF007AFF),
              ),
              otherAccountsPictures: [
                IconButton(
                  icon: const Icon(Icons.password, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.exit_to_app, color: Colors.white),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.list, color: Color(0xFF007AFF)),
                  title: const Text('Danh Sách Người Dùng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeviceListScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Color(0xFF007AFF)),
                  title: const Text('Lịch Sử Sử Dụng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UsageHistoryScreen()),
                    );
                  },
                ),
                const Divider(),
                const ListTile(
                  title: Text('Chi Tiết Thiết Bị', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                ListTile(
                  leading: const Icon(Icons.timer, color: Color(0xFF007AFF)),
                  title: const Text('Thời Gian Sử Dụng: 45 phút'),
                  trailing: const Icon(Icons.delete, color: Colors.red),
                  onTap: () {
                    // Xử lý chức năng xóa
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.online_prediction, color: Color(0xFF007AFF)),
                  title: Text('Trạng Thái: Online'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.timer, color: Color(0xFF007AFF)),
                  title: const Text('Cài Đặt Thời Gian'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetTimerPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.qr_code_scanner, color: Color(0xFF007AFF)),
                  title: const Text('Quét Mã QR'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ScanQrPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
