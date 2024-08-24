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
      deviceStatus = 'Trạng thái: Trực tuyến';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AST Remote'),
        backgroundColor: const Color(0xFF1E88E5),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _resetScreen,
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Padding(
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
                color: Color(0xFF1E88E5),
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
            _buildRemoteControl(context),
          ],
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                title: const Text('Kết nối với'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.bluetooth, color: Color(0xFF1E88E5)),
                      title: const Text('Bluetooth'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BluetoothPage()),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.wifi, color: Color(0xFF1E88E5)),
                      title: const Text('Wi-Fi'),
                      onTap: () {
                        Navigator.pop(context);
                        // Add Wi-Fi connection code here
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

  Widget _buildRemoteControl(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFF1E88E5), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildRemoteControlRow(
              [
                _buildControlButton(Icons.arrow_upward, 'Lên', context),
              ],
            ),
            const SizedBox(height: 24),
            _buildRemoteControlRow(
              [
                _buildControlButton(Icons.lock, 'Khóa', context),
                const SizedBox(width: 16),
                _buildControlButton(Icons.lock_open, 'Mở', context),
              ],
            ),
            const SizedBox(height: 24),
            _buildRemoteControlRow(
              [
                _buildControlButton(Icons.arrow_downward, 'Xuống', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, String label, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(20),
        shape: const CircleBorder(),
        backgroundColor: const Color(0xFF1E88E5),
        shadowColor: Colors.black45,
        elevation: 8,
      ),
      onPressed: () {
        setState(() {
          deviceStatus = 'Trạng thái: Đang hoạt động';
        });
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRemoteControlRow(List<Widget> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E88E5),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
            ),
            child: UserAccountsDrawerHeader(
              accountName: const Text('Tên Người Dùng', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              accountEmail: const Text('user@example.com', style: TextStyle(color: Colors.white)),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 50, color: Color(0xFF1E88E5)),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF1E88E5),
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
                  leading: const Icon(Icons.list, color: Color(0xFF1E88E5)),
                  title: const Text('Danh Sách Người Dùng'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeviceListScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.history, color: Color(0xFF1E88E5)),
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
                  leading: const Icon(Icons.timer, color: Color(0xFF1E88E5)),
                  title: const Text('Thời Gian Sử Dụng: 45 phút'),
                  trailing: const Icon(Icons.delete, color: Colors.red),
                  onTap: () {
                    // Handle delete functionality
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.online_prediction, color: Color(0xFF1E88E5)),
                  title: Text('Trạng Thái: Online'),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.timer, color: Color(0xFF1E88E5)),
                  title: const Text('Cài Đặt Thời Gian'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetTimerPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.qr_code_scanner, color: Color(0xFF1E88E5)),
                  title: const Text('Quét QR'),
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
          const ListTile(
            title: Text('Phiên Bản: 1.0.0', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
