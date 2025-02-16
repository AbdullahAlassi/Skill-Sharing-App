import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Events'),
            onTap: () {
              Navigator.pushNamed(context, '/events');
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Progress Tracking'),
            onTap: () {
              Navigator.pushNamed(context, '/progress');
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Resource Library'),
            onTap: () {
              Navigator.pushNamed(context, '/resources');
            },
          ),
        ],
      ),
    );
  }
}
