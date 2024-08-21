import 'package:flutter_blue/flutter_blue.dart';

class BluetoothService {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  var characteristics;

  void sendCommand(String command) async {
    // Tìm thiết bị
    flutterBlue.startScan(timeout: Duration(seconds: 4));

    // Lắng nghe kết quả quét
    flutterBlue.scanResults.listen((results) async {
      for (ScanResult r in results) {
        print('${r.device.name} found! RSSI: ${r.rssi}');

        try {
          // Kết nối với thiết bị
          await r.device.connect();
          print('Connected to ${r.device.name}');

          // Tìm dịch vụ và characteristic
          List<BluetoothService> services = (await r.device.discoverServices()).cast<BluetoothService>();
          BluetoothCharacteristic? targetCharacteristic;

          for (var service in services) {
            for (var characteristic in service.characteristics) {
              if (characteristic.properties.write) {
                targetCharacteristic = characteristic;
                break;
              }
            }
          }

          if (targetCharacteristic != null) {
            // Gửi lệnh qua Bluetooth
            await targetCharacteristic.write(command.codeUnits);
            print('Command sent: $command');
          } else {
            print('No writable characteristic found.');
          }
        } catch (e) {
          print('Failed to connect or send command: $e');
        } finally {
          // Ngắt kết nối sau khi gửi lệnh
          await r.device.disconnect();
          print('Disconnected from ${r.device.name}');
        }
      }
    });
  }
}
