import 'package:flutter/material.dart';

class ResourceLibraryScreen extends StatelessWidget {
  const ResourceLibraryScreen({super.key});

  final List<Map<String, String>> resources = const <Map<String, String>>[
    {"title": "Flutter Tutorial", "link": "https://flutter.dev"},
    {"title": "Python for Beginners", "link": "https://python.org"},
    {"title": "UI Design Guide", "link": "https://design.google"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resource Library')),
      body: ListView.builder(
        itemCount: resources.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, String> resource = resources[index];
          return ListTile(
            title: Text(resource['title']!),
            subtitle: Text(resource['link']!),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Opening ${resource['title']}')),
              );
            },
          );
        },
      ),
    );
  }
}
