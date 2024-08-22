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
            _buildSearchBar(),
            const SizedBox(height: 24),
            _buildDeviceHeader('Thiết Bị 1', 'Đã kết nối', 'Tên Người Dùng'),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: <Widget>[
                  _buildUserTile('John Doe', '01/01/2024', 'john.doe@example.com', '+123456789'),
                  _buildUserTile('Jane Smith', '02/01/2024', 'jane.smith@example.com', '+987654321'),
                  _buildUserTile('Alice Johnson', '03/01/2024', 'alice.johnson@example.com', '+456789123'),
                  // Add more users as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          hintText: 'Tìm kiếm người dùng',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onChanged: (text) {
          // Handle search functionality
        },
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
              fontSize: 20, // Giảm kích thước chữ
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Trạng Thái Kết Nối: $connectionStatus',
                  style: const TextStyle(
                    fontSize: 16, // Giảm kích thước chữ
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis, // Cắt bớt văn bản nếu quá dài
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Người Dùng: $userName',
                  style: const TextStyle(
                    fontSize: 16, // Giảm kích thước chữ
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis, // Cắt bớt văn bản nếu quá dài
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(String userName, String date, String email, String phoneNumber) {
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
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ngày: $date',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              'Email: $email',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            Text(
              'Số Điện Thoại: $phoneNumber',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
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
