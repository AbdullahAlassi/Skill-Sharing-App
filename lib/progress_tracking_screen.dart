import 'package:flutter/material.dart';

class ProgressTrackingScreen extends StatefulWidget {
  const ProgressTrackingScreen({super.key});

  @override
  ProgressTrackingScreenState createState() => ProgressTrackingScreenState();
}

class ProgressTrackingScreenState extends State<ProgressTrackingScreen> {
  final List<Map<String, dynamic>> goals = <Map<String, dynamic>>[
    {"description": "Complete Flutter Course", "progress": 50},
    {"description": "Learn 50 Python functions", "progress": 70},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Tracking')),
      body: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, dynamic> goal = goals[index];
          return ListTile(
            title: Text(goal['description'] as String),
            subtitle: LinearProgressIndicator(
              value: (goal['progress'] as int) / 100,
              backgroundColor: Colors.grey[300],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          );
        },
      ),
    );
  }
}
