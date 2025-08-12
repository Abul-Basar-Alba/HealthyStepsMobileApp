import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/messaging_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _messagingService = MessagingService();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final adminId = 'admin_id'; // অ্যাডমিনের আইডি হার্ডকোড (ল্যাটার ডায়নামিক করবে)

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color(0xFF26A69A),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Email: ${user?.email ?? ''}'),
            subtitle: Text('Contact: ${user?.contactNumber ?? ''}'),
          ),
          TextField(
            controller: _messageController,
            decoration: InputDecoration(labelText: 'Message to Admin'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFCA28)),
            onPressed: () {
              _messagingService.sendMessage(user!.id!, adminId, _messageController.text);
              _messageController.clear();
            },
            child: Text('Send', style: TextStyle(color: Colors.white)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFCA28)),
            onPressed: () => Provider.of<UserProvider>(context, listen: false).logout(),
            child: Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}