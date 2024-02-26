import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
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

class Exo7b extends StatefulWidget {
  final List<Widget> tiles;
  final double numberOfRows;
  final double levelOfShuffle;
  const Exo7b({super.key,required this.tiles, required this.numberOfRows, required this.levelOfShuffle});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

class PositionedTilesState extends State<Exo7b> {
  late int indexVoidTile; // index tile blanche
  late  List <WidgetTile> boardTile; // plateau
  int nbCout = 0;

  @override
  void initState() {
    super.initState();
    //1. on créé la list de tile qui sont ici des widgets, c'est le plateau
    boardTile = buildWidgetTile();
    //2. on identifie l'index de la Tile est "vide"
    indexVoidTile = findVoidTileIndex();
    //3. On mélange les tiles, de sorte que le puzzle soit résolvable
    shuffleTiles();
    //4. On met les tiles adjacente à la tile "vide" en clickable
    setClick(findAdjacentTiles(indexVoidTile));
    const d = const Duration(milliseconds: 1000);
    new Timer.periodic(d, stopWatch);
  }

  //1. creation du plateau
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
// 2.
  int findVoidTileIndex() {
    for (int index = 0; index < boardTile.length; index++) {
      if (boardTile[index].isTileVoid) {
        return index;
      }
    }
    return -1; //  -1 si aucune tuile avec isTileVoid == true
  }
  //3.
  void shuffleTiles() {
    Random random = Random();
    double level = (widget.numberOfRows*widget.numberOfRows*widget.levelOfShuffle)*widget.levelOfShuffle;
    for (int i = 0; i < level.toInt() ; i++) {
      List <int> adjacentIndices = findAdjacentTiles(indexVoidTile);

      int randomIndex = adjacentIndices[random.nextInt(adjacentIndices.length)];

      swipeTiles(randomIndex);

      indexVoidTile = randomIndex;
    }
  }

//4
  void setClick (List<int> adjacentIndices){
    // on met toutes les tiles à isClickable false
    boardTile.forEach  ((tile) => tile.isClickable = false);
    // on met les tuiles adjacente clickable
    for (int adjacentIndex in adjacentIndices) {
      boardTile[adjacentIndex].isClickable  = true;
    }
  }

  List<int>  findAdjacentTiles(int indexVoidTile) {

    int gridSize = widget.numberOfRows.toInt();
    int row = indexVoidTile ~/ gridSize; // la ligne où est la tile blanche
    int col = indexVoidTile % gridSize; // colone où est la tile blanche
// on chercher les tuiles adjacentes
    List<int> adjacentIndices = [];

    if (row > 0) adjacentIndices.add(indexVoidTile - gridSize); // Tuile au-dessus
    if (row < gridSize - 1) adjacentIndices.add(indexVoidTile + gridSize); // Tuile en dessous
    if (col > 0) adjacentIndices.add(indexVoidTile - 1); // Tuile à gauche
    if (col < gridSize - 1) adjacentIndices.add(indexVoidTile + 1); // Tuile à droite
    return  adjacentIndices;

  }

  void onAdjacentTileTap(int adjacentIndex) {
    setState(() {
      swipeTiles(adjacentIndex);
      indexVoidTile = adjacentIndex; // on change la tile blanche
      setClick(findAdjacentTiles(indexVoidTile));// on met a jour les tuiles clickable
      nbCout++;
    });
  }

  void swipeTiles (int index){
    WidgetTile temp = boardTile[indexVoidTile];
    boardTile[indexVoidTile] = boardTile[index];
    boardTile[index] = temp;
  }

  int heures = 0;
  int minutes = 0;
  int secondes = 0;
  void stopWatch(Timer t){
    setState(() {
      secondes = secondes + 1;
      if (secondes == 60) {
        secondes = 0;
        minutes = minutes + 1;
      }
      if (minutes == 60) {
        minutes = 0;
        heures = heures + 1;
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jeu du Taquin'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: 380,
                height: 380,
                child: GridView.count(
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
                      ),
                  ],
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(30)),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(nbCout.toString(),
                      style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5, color: Colors.deepPurple, decoration: TextDecoration.none)
                  ),
                  Text(" coups.",
                  style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.01, color: Colors.black, decoration: TextDecoration.none )),
            ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Temps écoulé : " + heures.toString().padLeft(2, '0') + ":"
                      + minutes.toString().padLeft(2, '0') + ":"
                      + secondes.toString().padLeft(2, '0'),
                    style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 0.5, color: Colors.black, decorationColor: Colors.deepPurple),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }


}
