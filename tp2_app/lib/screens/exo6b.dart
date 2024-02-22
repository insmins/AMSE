import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tp2_app/screens/exo4.dart';
import 'package:tp2_app/screens/exo6a.dart';
// ==============
// Widgets
// ==============

class Exo6b extends StatefulWidget {
  const Exo6b({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

Widget tileWidget(TileExo6 tile){
  return Container(
    color: tile.color,
    child: Center(
      child: Text(
        tile.numberTile.toString(),
            style: const TextStyle(
          fontSize: 15.0,
              fontWeight: FontWeight.bold,
      ),
      ),
    ),
  );
}


class PositionedTilesState extends State<Exo6b> {
  late int indexVoidTile; // index tile blanche


  List<TileExo6> tiles = List<TileExo6>.generate(
    9,
    (index) {
      if (index < 8) {
      return (TileExo6.construct(index));
      } else {
      return (TileExo6(Color(0xFFFFFFFF), false, true, 8)); // Blanc
      }
      },
      );
  @override
  void initState() {
    super.initState();
    indexVoidTile = findVoidTileIndex(); // on met a jour la valeur de l'index du tile blanc
    findAdjacentTiles(indexVoidTile);
  }

  int findVoidTileIndex() {
    for (int index = 0; index < tiles.length; index++) {
      if (tiles[index].isTileVoid) {
        return index;
      }
    }
    return -1; //  -1 si aucune tuile avec isTileVoid == true
  }

  void findAdjacentTiles(int indexVoidTile) {

    int gridSize = 3;
    int row = indexVoidTile ~/ gridSize; // la ligne où est la tile blanche
    int col = indexVoidTile % gridSize; // colone où est la tile blanche
// on chercher les tuiles adjacentes
    List<int> adjacentIndices = [];

    if (row > 0) adjacentIndices.add(indexVoidTile - gridSize); // Tuile au-dessus
    if (row < gridSize - 1) adjacentIndices.add(indexVoidTile + gridSize); // Tuile en dessous
    if (col > 0) adjacentIndices.add(indexVoidTile - 1); // Tuile à gauche
    if (col < gridSize - 1) adjacentIndices.add(indexVoidTile + 1); // Tuile à droite

    // on met toutes les tiles à isClickable false
      tiles.forEach ((tile) => tile.isClickable = false);
      // on met les tuiles adjacente clickable
      for (int adjacentIndex in adjacentIndices) {
          tiles[adjacentIndex].isClickable = true;
      }
  }
  void onAdjacentTileTap(int adjacentIndex) {
    setState(() {
      TileExo6 temp = tiles[indexVoidTile];
      tiles[indexVoidTile] = tiles[adjacentIndex];
      tiles[adjacentIndex] = temp;
      indexVoidTile = adjacentIndex; // on change la tile blanche
      findAdjacentTiles(indexVoidTile); // on met a jour les tuiles clickable
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Moving tiles in grid'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
        crossAxisCount: 3,
        children: [
          for (int index = 0; index < tiles.length; index++)
            InkWell(
              onTap: tiles[index].isClickable
                  ? () {
                onAdjacentTileTap(index);
              }
                  : null,
              child: Container(
                decoration: BoxDecoration(
                  border: tiles[index].isClickable
                      ? Border.all(color: Colors.red, width: 3)
                      : null,
                ),
                child: tileWidget(tiles[index]),
              ),
            ),
        ],
      ),

    );
  }

}
