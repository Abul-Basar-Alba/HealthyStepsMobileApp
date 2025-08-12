import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../services/firestore_service.dart';
import '../models/diet_log.dart';

class DietLoggingScreen extends StatefulWidget {
  const DietLoggingScreen({super.key});

  @override
  _DietLoggingScreenState createState() => _DietLoggingScreenState();
}

class _DietLoggingScreenState extends State<DietLoggingScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final _foodController = TextEditingController();
  final _caloriesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
  final userId = Provider.of<UserProvider>(context).userId;

    return Scaffold(
      appBar: AppBar(
        title: Text('Diet Log'),
        backgroundColor: Color(0xFF26A69A),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _foodController,
                  decoration: InputDecoration(labelText: 'Food Item'),
                ),
                TextField(
                  controller: _caloriesController,
                  decoration: InputDecoration(labelText: 'Calories'),
                  keyboardType: TextInputType.number,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFFFCA28)),
                  onPressed: userId == null ? null : () {
                    _firestoreService.addDietLog(userId, DietLog(
                      foodItem: _foodController.text,
                      calories: int.tryParse(_caloriesController.text),
                      date: DateTime.now(),
                    ));
                    _foodController.clear();
                    _caloriesController.clear();
                  },
                  child: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<List<DietLog>>(
              stream: userId == null ? null : _firestoreService.getDietLogs(userId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                // final totalCalories = snapshot.data!.map((e) => e.calories ?? 0).reduce((a, b) => a + b);
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final log = snapshot.data![index];
                    return ListTile(
                      title: Text('${log.foodItem} - ${log.calories} cal'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}