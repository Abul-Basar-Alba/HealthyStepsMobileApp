import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import '../models/challenge.dart';

class CommunityScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  CommunityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Community'),
        backgroundColor: Color(0xFF26A69A),
      ),
      body: StreamBuilder<List<Challenge>>(
        stream: _firestoreService.getChallenges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final challenge = snapshot.data![index];
              return Card(
                color: Color(0xFF4CAF50),
                child: ListTile(
                  title: Text(challenge.title ?? '', style: TextStyle(color: Colors.white)),
                  subtitle: Text('Goal: ${challenge.goalSteps} steps', style: TextStyle(color: Colors.white)),
                  trailing: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFCA28)),
                    onPressed: userId == null ? null : () => _firestoreService.joinChallenge(userId!, challenge.id!),
                    child: Text('Join', style: TextStyle(color: Colors.white)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}