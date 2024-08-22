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
        _history = _history.where((item) => item['date'] == '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}').toList();
      });
    }
  }

  void _deleteItem(int index) {
    setState(() {
      _history.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lịch Sử Sử Dụng'),
        backgroundColor: const Color(0xFF007AFF),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _filterByDate,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _history.isEmpty
            ? const Center(child: Text('Không có dữ liệu cho ngày này', style: TextStyle(fontSize: 16)))
            : ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return _buildHistoryItem(index);
                },
              ),
      ),
    );
  }

  Widget _buildHistoryItem(int index) {
    final item = _history[index];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 6,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF007AFF), Color(0xFF1E90FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            item['name']!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 8),
              Text(
                'Thời gian: ${item['time']}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Ngày: ${item['date']}',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Trạng thái: ${item['status']}',
                style: TextStyle(
                  color: item['status'] == 'Mở' ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.redAccent),
            onPressed: () {
              // Hiển thị hộp thoại xác nhận xóa
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Xóa mục'),
                  content: const Text('Bạn có chắc chắn muốn xóa mục này?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Hủy'),
                    ),
                    TextButton(
                      onPressed: () {
                        _deleteItem(index);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Xóa'),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
