import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import '../models/step_data.dart';

class StepTrackingScreen extends StatelessWidget {
  final FirestoreService _firestoreService = FirestoreService();

  StepTrackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Step Tracker'),
        backgroundColor: Color(0xFF26A69A),
      ),
      body: StreamBuilder<List<StepData>>(
        stream: userId == null ? null : _firestoreService.getStepData(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final stepsData = snapshot.data!;
          final totalSteps = stepsData.map((e) => e.stepsCount ?? 0).reduce((a, b) => a + b);
          final totalCalories = stepsData.map((e) => e.caloriesBurned ?? 0).reduce((a, b) => a + b);
          final totalDistance = stepsData.map((e) => e.distance ?? 0).reduce((a, b) => a + b);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Placeholder(), // Replace with a line graph (e.g., fl_chart package)
                ),
                Card(
                  color: Color(0xFF4CAF50),
                  child: ListTile(
                    title: Text('Total Steps: $totalSteps', style: TextStyle(color: Colors.white)),
                    subtitle: Text('Calories Burned: $totalCalories kcal', style: TextStyle(color: Colors.white)),
                    trailing: Text('Distance: ${totalDistance.toStringAsFixed(2)} km', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}