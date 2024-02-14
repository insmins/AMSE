import 'package:flutter/material.dart';
import 'package:tp2_app/home.dart';
import 'package:tp2_app/screens/exo1.dart';
import 'package:tp2_app/screens/exo4.dart';
import 'package:tp2_app/screens/exo5.dart';

void main() {
  runApp(const MyApp());
}

List <Exercice> exo =[
  Exercice("exercice 1", "afficher une image", const Exo1()),
  Exercice("exercice 4", "Affichage d'une tuile (un morceau d'image)", const DisplayTileWidget()),
  Exercice("exercice 5", "Génération du plateau de tuiles", const Exo5()),

];
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TP2_app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeMenuScreen(exercices: exo,),
    );
  }
}


