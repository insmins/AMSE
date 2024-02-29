import 'package:flutter/material.dart';

import 'exo7a.dart';

class Galerie extends StatelessWidget {
  const Galerie({Key? key});

  @override
  Widget build(BuildContext context) {
    List<String> imagePaths = [
      '../assets/bol_de_fruit.jpg',
      '../assets/chat.jpeg',
      '../assets/chien1.jpg',
      '../assets/chien2.jpg',
      '../assets/flutter_logo.jpg',
      '../assets/duckpourpre_ptit.jpg',
      '../assets/hero_omori.png',
      '../assets/logo_bdh.jpg',
      '../assets/paddington.jpg',
      '../assets/sonny_boy.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Galerie d\'images'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: imagePaths.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Exo7a(imageAsset: Image.asset(imagePaths[index]))),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(imagePaths[index]),
            ),
          );
        },
      ),
    );
  }
}
