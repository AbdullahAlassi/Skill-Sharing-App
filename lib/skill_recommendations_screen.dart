import 'package:flutter/material.dart';

class SkillRecommendationsScreen extends StatelessWidget {
  const SkillRecommendationsScreen({super.key});

  final List<Map<String, String>> recommendedSkills = const <Map<String, String>>[
    {"name": "Flutter", "description": "Learn to build beautiful apps."},
    {"name": "Python", "description": "Master Python for data science."},
    {"name": "UI/UX Design", "description": "Improve your design skills."},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skill Recommendations')),
      body: ListView.builder(
        itemCount: recommendedSkills.length,
        itemBuilder: (BuildContext context, int index) {
          final Map<String, String> skill = recommendedSkills[index];
          return ListTile(
            title: Text(skill['name']!),
            subtitle: Text(skill['description']!),
            trailing: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('You selected ${skill['name']}')),
                );
              },
              child: const Text('Learn'),
            ),
          );
        },
      ),
    );
  }
}
