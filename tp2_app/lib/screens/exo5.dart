import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2_app/screens/exo4.dart';

class Exo5 extends StatelessWidget {
  const Exo5({Key? key});


  @override
  Widget build(BuildContext context) {
    List<Alignment> tileAlignements = [
      Alignment(-1, -1), Alignment(0, -1), Alignment(1, -1),
      Alignment(-1, 0), Alignment(0, 0), Alignment(1, 0),
      Alignment(-1, 1), Alignment(0, 1), Alignment(1, 1),
    ];
    List<Tile> tile = [];
    for (int i = 0; i < tileAlignements.length; i++) {
      tile.add(Tile(imageURL: 'https://picsum.photos/512', alignment: tileAlignements[i]));

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Génération du plateau de tuiles'),
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(10),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        children: List.generate(
          9,
              (index) => Container(
            padding: const EdgeInsets.all(0),
            child: _getTile(index, tile[index]),
          ),
        ),
      ),
    );
  }

  Widget _getTile(int index, Tile tile) {

    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 150.0,
            height: 150.0,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: createTileWidgetFrom(tile)
            )
    ),
    ],
    ),
    );
  }
  Widget createTileWidgetFrom(Tile tile) {
    return InkWell(
      child: tile.croppedImageTile(),
      onTap: () {
        print("La tuile a été tapée !");
      },
    );
  }
}
