import 'package:flutter/material.dart';
import 'package:tp2_app/home.dart';
import 'package:tp2_app/screens/exo1.dart';
import 'package:tp2_app/screens/exo2b.dart';
import 'package:tp2_app/screens/exo4.dart';
import 'package:tp2_app/screens/exo5b.dart';
import 'package:tp2_app/screens/exo2.dart';
import 'package:tp2_app/screens/exo5a.dart';
import 'package:tp2_app/screens/exo6a.dart';
import 'package:tp2_app/screens/exo6b.dart';
import 'package:tp2_app/screens/exo7a.dart';

void main() {
  runApp(const MyApp());
}

List <Exercice> exo =[
  Exercice("Exercice 1", "afficher une image", const Exo1()),
  Exercice("Exercice 2a", "transformer une image", const Exo2()),
  Exercice("Exercice 2b", "Transformer et animer", const Exo2b()),
  Exercice("Exercice 4", "Affichage d'une tuile (un morceau d'image)", const DisplayTileWidget()),
  Exercice("Exercice 5a", "Fixed grid of cropped image", Exo5a()),
  Exercice("Exercice 5b", "Configurable Taquin Board",  Exo5b()),
  Exercice("Exercice 6a", "Moving tile", PositionedTiles()),
  Exercice("Exercice 6b", "Moving tiles in grid", Exo6b()),
  Exercice("Exercice 7a", "Jeu du taquin", Exo7a()),


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


