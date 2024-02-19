import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tile {
  String imageURL;
  /* Explication alignement : ---------------------------------------
*  Les valeurs sont comprises entre -1 et 1, où -1 signifie le côté gauche ou
*  le haut, 1 signifie le côté droit ou le bas, et 0 signifie le centre.
   */
  Alignment alignment;

  Tile({required this.imageURL, required this.alignment});

  Widget croppedImageTile(double  widthFactor, double heightFactor) {
    return FittedBox(
      fit: BoxFit.fill,
      child: ClipRect(
        child: Align(
          alignment: alignment,
          widthFactor: widthFactor,
          heightFactor: heightFactor,
          child: Image.network(imageURL),
        ),
      ),
    );
  }
}

Tile tile = Tile(
    imageURL: 'https://picsum.photos/512', alignment: const Alignment(0,0));

class DisplayTileWidget extends StatelessWidget {
  const DisplayTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Display a Tile as a Cropped Image'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
              children: [
                SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: Container(
                        margin: const EdgeInsets.all(20.0),
                        child: this.createTileWidgetFrom(tile))),
            Container(
                height: 200,
                child: Image.network('https://picsum.photos/512',
                    fit: BoxFit.cover
                ))
          ])),
    );
  }

  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(0.3,0.3),
      onTap: () {
        print("La tuile a été tapée !");
      },
    );
  }
}