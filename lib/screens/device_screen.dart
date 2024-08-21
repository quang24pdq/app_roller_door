import 'package:flutter/material.dart';

class DeviceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Device List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildDeviceHeader('Device 1', 'Connected', 'User Name'),
            SizedBox(height: 16),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deviceName,
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Connection Status: $connectionStatus',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            'User: $userName',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget _buildUserTile(String userName, String date) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(userName, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Date: $date'),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            // Handle delete functionality
          },
        ),
      ),
    );
  }
}
