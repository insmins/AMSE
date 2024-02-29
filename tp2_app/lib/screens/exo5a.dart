import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2_app/screens/exo4.dart';

class Exo5a extends StatelessWidget {
  const Exo5a({super.key});


  @override
  Widget build(BuildContext context) {

    List<Alignment> tileAlignements = [
      Alignment(-1, -1), Alignment(0, -1), Alignment(1, -1),
      Alignment(-1, 0), Alignment(0, 0), Alignment(1, 0),
      Alignment(-1, 1), Alignment(0, 1), Alignment(1, 1),
    ];

    List<Tile> tile = [];
    for (int i = 0; i < tileAlignements.length; i++) {
      tile.add(Tile(alignment: tileAlignements[i]));

    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Génération du plateau de tuiles'),
      ),
      body: GridView.count(
        padding: EdgeInsets.all(30),
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
        crossAxisCount: 3,
        children: List.generate(
          9,
              (index) => _getTile(index, tile[index]),
          ),
      ),
    );
  }

  Widget _getTile(int index, Tile tile) {
    return Container(
        child: createTileWidgetFrom(tile)
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
