import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/home_screen.dart';
import 'providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAIjvrB3RkOBhg6TX1WX1S3eUl0t_uD3O-jjo", // Corrected typo
        authDomain: "healthapps-37d6f.firebaseapp.com",
        projectId: "healthapps-37d6f",
        storageBucket: "healthapps-37d6f.firebasestorage.app",
        messagingSenderId: "476787809902",
        appId: "1:476787809902:web:0657851a817fe815c1d07f",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HealthySteps',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Color(0xFF4CAF50)), // Replaced deprecated accentColor
      ),
      home: HomeScreen(),
    );
  }
}