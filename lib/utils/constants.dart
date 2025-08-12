import 'package:flutter/material.dart';

class Constants {
  // রঙ
  static const Color primaryColor = Color(0xFF26A69A); // টিল-গ্রিন
  static const Color secondaryColor = Color(0xFF4CAF50); // গ্রিন
  static const Color accentColor = Color(0xFFFFCA28); // হলুদ (বোতামের জন্য)
  static const Color errorColor = Colors.red; // ত্রুটির জন্য

  // স্ট্রিং
  static const String appName = 'HealthySteps';
  static const String baseUrl = 'https://your-firebase-app.web.app';
  static const String adminEmail = 'admin@healthysteps.com'; // ডিফল্ট অ্যাডমিন ইমেইল

  // ফিচার-সম্পর্কিত কনস্ট্যান্ট
  static const int dailyStepGoal = 10000; // দৈনিক স্টেপ লক্ষ্য
  static const double maxCalorieIntake = 2000.0; // সর্বোচ্চ ক্যালোরি লিমিট
  static const List<String> categories = ['Baby', 'Pregnancy', 'Heart']; // ক্যাটাগরি তালিকা
}