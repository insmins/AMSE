import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tp2_app/screens/exo4.dart';



// =================
// Model
//==================
// c'est un widget avec l'image coupé et l'ajout des booleen dont on a besoin
//pour gerer le jeu
class WidgetTile {
  late Widget tile;
  late bool isClickable;
  late bool isTileVoid;

  WidgetTile({required this.tile, required this.isClickable, required this.isTileVoid});
}
// ==============
// Widgets
// ==============

class Exo7 extends StatefulWidget {
  final List<Widget> tiles;
  final double numberOfRows;
  const Exo7({super.key,required this.tiles, required this.numberOfRows});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<Exo7> {
  late int indexVoidTile; // index tile blanche
  late  List <WidgetTile> boardTile; // plateau

  @override
  void initState() {
    super.initState();
    print (widget.tiles.length);
    print(widget.numberOfRows);
    boardTile = buildWidgetTile(); // on crééer le tableau de tuiles qui nous servira de plateau
    indexVoidTile = findVoidTileIndex(); // on met a jour la valeur de l'index du tile blanc
    findAdjacentTiles(indexVoidTile);


  }

  List<WidgetTile> buildWidgetTile () {
    List<WidgetTile> widgetTiles = List<WidgetTile>.generate(
      widget.tiles.length,
          (index) {
        if (index < (widget.tiles.length -1)) {
          return (WidgetTile(tile : widget.tiles[index],isClickable: false, isTileVoid: false));
        } else {
          return (WidgetTile(tile: widget.tiles[index], isClickable: false, isTileVoid: true)); // Blanc
        }
      },
    );
    return widgetTiles;
  }
  
  int findVoidTileIndex() {
    for (int index = 0; index < boardTile.length; index++) {
      if (boardTile[index].isTileVoid) {
        return index;
      }
    }
    return -1; //  -1 si aucune tuile avec isTileVoid == true
  }

  void findAdjacentTiles(int indexVoidTile) {

    int gridSize = widget.numberOfRows.toInt();
    int row = indexVoidTile ~/ gridSize; // la ligne où est la tile blanche
    int col = indexVoidTile % gridSize; // colone où est la tile blanche
// on chercher les tuiles adjacentes
    List<int> adjacentIndices = [];

    if (row > 0) adjacentIndices.add(indexVoidTile - gridSize); // Tuile au-dessus
    if (row < gridSize - 1) adjacentIndices.add(indexVoidTile + gridSize); // Tuile en dessous
    if (col > 0) adjacentIndices.add(indexVoidTile - 1); // Tuile à gauche
    if (col < gridSize - 1) adjacentIndices.add(indexVoidTile + 1); // Tuile à droite

    // on met toutes les tiles à isClickable false
    boardTile.forEach  ((tile) => tile.isClickable = false);
    // on met les tuiles adjacente clickable
    for (int adjacentIndex in adjacentIndices) {
      boardTile[adjacentIndex].isClickable  = true;
    }
  }
  void onAdjacentTileTap(int adjacentIndex) {
    setState(() {
      WidgetTile temp = boardTile[indexVoidTile];
      boardTile[indexVoidTile] = boardTile[adjacentIndex];
      boardTile[adjacentIndex] = temp;
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
        crossAxisCount: widget.numberOfRows.toInt(),
        children: [
          for (int index = 0; index < boardTile.length; index++)
            InkWell(
              onTap: boardTile[index].isClickable
                  ? () {
                onAdjacentTileTap(index);
              }
                  : null,
              child: Visibility(
                visible: !boardTile[index].isTileVoid,
                child: Container(
                  decoration: BoxDecoration(
                    border: boardTile[index].isClickable
                        ? Border.all(color: Colors.red, width: 3)
                        : null,
                  ),
                  child: boardTile[index].tile,
                ),
              ),
            )
          ,

        ],
      ),

    );
  }

}
