import 'package:flutter/material.dart';

class DeviceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh Sách Thiết Bị'),
        backgroundColor: const Color(0xFF007AFF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDeviceHeader('Thiết Bị 1', 'Đã kết nối', 'Tên Người Dùng'),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildUserTile('John Doe', '01/01/2024'),
                  _buildUserTile('Jane Smith', '02/01/2024'),
                  _buildUserTile('Alice Johnson', '03/01/2024'),
                  // Add more users as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceHeader(String deviceName, String connectionStatus, String userName) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF007AFF), Color(0xFF1E90FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deviceName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Trạng Thái Kết Nối: $connectionStatus',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Người Dùng: $userName',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(String userName, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          userName,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          'Ngày: $date',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle delete functionality
          },
        ),
      ),
    );
  }
}
