import 'package:flutter/material.dart';

class EventScreen extends StatelessWidget {
  final List<Map<String, String>> events = <Map<String, String>>[
    <String, String>{"name": "Flutter Workshop", "date": "Dec 30, 2024"},
    <String, String>{"name": "Python Webinar", "date": "Jan 15, 2025"},
  ];

   EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events & Workshops')),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, String> event = events[index];
          return ListTile(
            title: Text(event['name']!),
            subtitle: Text(event['date']!),
            trailing: ElevatedButton(
              onPressed: () {
                debugPrint('Registered for ${event['name']}');
              },
              child: const Text('Register'),
            ),
          );
        },
      ),
    );
  }
}
  