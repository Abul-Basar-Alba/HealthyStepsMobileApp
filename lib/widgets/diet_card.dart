import 'package:flutter/material.dart';
import '../models/diet_log.dart';

class DietCard extends StatelessWidget {
  final DietLog dietLog;
  final VoidCallback? onDelete;

  const DietCard({required this.dietLog, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF4CAF50),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.fastfood, color: Colors.white),
        title: Text(
          dietLog.foodItem ?? 'Unknown Food',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Calories: ${dietLog.calories ?? 0} cal | Protein: ${dietLog.protein?.toStringAsFixed(1) ?? 0}g',
          style: TextStyle(color: Colors.white70),
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }
}