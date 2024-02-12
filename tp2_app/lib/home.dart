import 'package:flutter/material.dart';
import 'package:tp2_app/screens/exo1.dart';

class Exercice {
  late final String title;
  late final String description;
  final Widget exoWidget;
  Exercice(this.title, this.description, this.exoWidget);
}

class HomeMenuScreen extends StatelessWidget {
  const HomeMenuScreen({super.key, required this.exercices});

  final List<Exercice> exercices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercices'),
      ),
      body: ListView.builder(
        itemCount: exercices.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(exercices[index].title),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => exercices[index].exoWidget,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

