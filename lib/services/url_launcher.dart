import 'package:flutter/material.dart';


class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.wifi, color: Color(0xFF007AFF)),
            title: const Text('Wi-Fi'),
            onTap: () async {
              const wifiSettingsUrl = 'wifi://'; // URL để mở cài đặt Wi-Fi
              if (await canLaunch(wifiSettingsUrl)) {
                await launch(wifiSettingsUrl);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Không thể mở cài đặt Wi-Fi')),
                );
              }
            },
          ),
          // Thêm các mục cài đặt khác ở đây
        ],
      ),
    );
  }
  
  canLaunch(String wifiSettingsUrl) {}
  
  launch(String wifiSettingsUrl) {}
}
