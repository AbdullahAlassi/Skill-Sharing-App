import 'package:flutter/material.dart';

class SocialInteractionsScreen extends StatelessWidget {
  const SocialInteractionsScreen({super.key});

  final List<String> groups = const <String>[
    "Flutter Enthusiasts",
    "Python Developers",
    "UI Designers",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Social Interactions')),
      body: ListView.builder(
        itemCount: groups.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(groups[index]),
            trailing: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Joined ${groups[index]}')),
                );
              },
              child: const Text('Join'),
            ),
          );
        },
      ),
    );
  }
}
