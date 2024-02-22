import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class TileExo6 {
  late Color color;
  late bool isClickable;
  late bool isTileVoid;
  late int numberTile;
  TileExo6( this.color, this.isClickable, this.isTileVoid, this.numberTile);

    TileExo6.randomColor() {
      this.color= Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }
  TileExo6.construct(int numberTile) {
    this.color= Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
    this.numberTile = numberTile;
    this.isClickable = false;
    this.isTileVoid = false;

  }
}

// ==============
// Widgets
// ==============

class PositionedTiles extends StatefulWidget {
  const PositionedTiles({super.key});

  @override
  State<StatefulWidget> createState() => PositionedTilesState();
}

Widget coloredBox(TileExo6 tile) {
  return Container(
      color: tile.color,
      child: const Padding(
        padding: EdgeInsets.all(70.0),
      ));
}

class PositionedTilesState extends State<PositionedTiles> {


  List<TileExo6> tiles = List<TileExo6>.generate(
      2,
          (index) => TileExo6.randomColor(),
    );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moving Tiles'),
        centerTitle: true,
      ),
      body: GridView.count(
        crossAxisCount: tiles.length,
        children: tiles.map((tile) {
          return InkWell(
            onTap: () {
              swapTiles();
            },
            child: coloredBox(tile),
          );
        }).toList(),
      ),
    );
  }

  void swapTiles() {
    setState(() {
      tiles.insert(1, tiles.removeAt(0));
    });
  }
}
