import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import '../models/user.dart' as app_model;

class AdminPanelScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  AdminPanelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final appUser = userProvider.user;
    if (appUser == null || !appUser.isAdmin) return Center(child: Text('Access Denied'));

    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Panel'),
        backgroundColor: Color(0xFF4CAF50),
      ),
      body: StreamBuilder<List<app_model.User>>(
        stream: _firestoreService.getAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final user = snapshot.data![index];
              return ListTile(
                title: Text(user.email ?? ''),
                trailing: IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _firestoreService.deleteUser(user.id!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}