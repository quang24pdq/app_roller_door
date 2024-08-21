import 'package:flutter/material.dart';

class UsageHistoryScreen extends StatefulWidget {
  @override
  _UsageHistoryScreenState createState() => _UsageHistoryScreenState();
}

class _UsageHistoryScreenState extends State<UsageHistoryScreen> {
  DateTime _selectedDate = DateTime.now();
  List<Map<String, String>> _history = [
    {'name': 'Thiết bị 1', 'time': '08:00', 'date': '20/08/2024', 'status': 'Mở'},
    {'name': 'Thiết bị 2', 'time': '12:30', 'date': '19/08/2024', 'status': 'Đóng'},
    // Thêm dữ liệu mẫu khác tại đây
  ];

  void _filterByDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null && selectedDate != _selectedDate) {
      setState(() {
        _selectedDate = selectedDate;
        // Cập nhật danh sách _history để chỉ hiển thị các mục theo ngày đã chọn.
        // Đây là ví dụ đơn giản, bạn có thể thay đổi để phù hợp với dữ liệu của mình.
        _history = _history.where((item) => item['date'] == '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}').toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch Sử Sử Dụng'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _filterByDate,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _history.isEmpty
            ? Center(child: Text('Không có dữ liệu cho ngày này'))
            : ListView(
          children: _history.map((item) => _buildHistoryItem(
            name: item['name']!,
            time: item['time']!,
            date: item['date']!,
            status: item['status']!,
          )).toList(),
        ),
      ),
    );
  }

  Widget _buildHistoryItem({
    required String name,
    required String time,
    required String date,
    required String status,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 4,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Thời gian: $time'),
            Text('Ngày: $date'),
            Text('Trạng thái: $status'),
          ],
        ),
      ),
    );
  }
}
