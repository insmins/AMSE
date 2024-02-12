import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TP1_app/models/favorites.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container (
        alignment: Alignment.center,
          child : Column (
            mainAxisAlignment: MainAxisAlignment.center,

        children : <Widget>[
          Text(
            'About this app',
            style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
              ),
          ),
            Text(
              'Cette application permet de parcourir des livres en fonction de leur catégorie et les rajouter en favoris❤',
              style: const TextStyle(
                fontSize: 16.0,
              ),
            ),
    ],
      )

    )
    );
  }
}