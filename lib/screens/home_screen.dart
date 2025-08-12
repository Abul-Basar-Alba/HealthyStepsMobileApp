import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import '../models/step_data.dart';
import 'step_tracking_screen.dart';
import 'diet_logging_screen.dart';
import 'community_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('HealthySteps'),
        backgroundColor: Color(0xFF26A69A),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen())),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Welcome, ${Provider.of<UserProvider>(context).user?.email ?? 'User'}!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<StepData>>(
              stream: userId == null ? null : _firestoreService.getStepData(userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                final steps = snapshot.data!.isNotEmpty ? snapshot.data!.last.stepsCount ?? 0 : 0;
                return Card(
                  color: Color(0xFF4CAF50),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('$steps Steps', style: TextStyle(fontSize: 32, color: Colors.white)),
                        SizedBox(height: 10),
                        CircularProgressIndicator(value: steps / 10000, color: Color(0xFFFFCA28)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFCA28)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DietLoggingScreen())),
                child: Text('Diet Log', style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFCA28)),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityScreen())),
                child: Text('Community', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.directions_walk), label: 'Steps'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Community'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => StepTrackingScreen()));
          } else if (index == 2) Navigator.push(context, MaterialPageRoute(builder: (_) => CommunityScreen()));
          else if (index == 3) Navigator.push(context, MaterialPageRoute(builder: (_) => SettingsScreen()));
        },
      ),
    );
  }
}