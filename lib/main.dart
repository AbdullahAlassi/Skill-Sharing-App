import 'package:flutter/material.dart';
import 'package:skillapp/home_screen.dart';
import 'package:skillapp/login_screen.dart';
import 'package:skillapp/mongodb_service.dart';
import 'package:skillapp/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize MongoDB connection
  try {
    await MongoDBService.connect();
    print('✅ MongoDB initialized successfully');

    // Optional: Fetch users for debugging
    await fetchUsers();
  } catch (e) {
    print('❌ Error initializing MongoDB: $e');
  }

  runApp(const MyApp());
}

/// Fetch and print all users from MongoDB (Optional for debugging)
Future<void> fetchUsers() async {
  final users = await MongoDBService.fetch('users');

  if (users.isNotEmpty) {
    print('📋 Users List:');
    for (var user in users) {
      print(user);
    }
  } else {
    print('⚠️ No users found in the database.');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skill Sharing App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/login', // Ensures app starts on LoginScreen
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
