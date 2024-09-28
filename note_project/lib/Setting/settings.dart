import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            // Ảnh đại diện người dùng ở giữa
            const SizedBox(height: 40),
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: const NetworkImage(
                    'https://i.ytimg.com/vi/bD-VM10PWdw/maxresdefault.jpg'), // Sử dụng một ảnh đại diện mẫu từ URL
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.blueAccent,
                      width: 4.0,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
        
            // List các mục cài đặt
            Expanded(
              child: ListView(
                children: [
                  // Notification Setting
                  ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.blue),
                    title: const Text('Notification Setting'),
                    subtitle: const Text('Manage notification preferences'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      // Xử lý khi chọn mục cài đặt Notification
                    },
                  ),
                  const Divider(),
        
                  // Information Setting
                  ListTile(
                    leading: const Icon(Icons.info, color: Colors.blue),
                    title: const Text('Information Setting'),
                    subtitle: const Text('View and update personal information'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      // Xử lý khi chọn mục cài đặt Information
                    },
                  ),
                  const Divider(),
        
                  // Customization Setting
                  ListTile(
                    leading: const Icon(Icons.color_lens, color: Colors.blue),
                    title: const Text('Customization Setting'),
                    subtitle: const Text('Customize the app appearance'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      // Xử lý khi chọn mục cài đặt Customization
                    },
                  ),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}