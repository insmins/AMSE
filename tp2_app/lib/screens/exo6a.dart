import 'package:flutter/material.dart';
import 'dart:math' as math;

// ==============
// Models
// ==============

math.Random random = math.Random();

class TileExo6a {
  late Color color;
  TileExo6a(this.color);

    TileExo6a.randomColor() {
      this.color = Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
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

Widget coloredBox(TileExo6a tile) {
  return Container(
      color: tile.color,
      child: const Padding(
        padding: EdgeInsets.all(70.0),
      ));
}

class PositionedTilesState extends State<PositionedTiles> {


  List<TileExo6a> tiles = List<TileExo6a>.generate(
      2,
          (index) => TileExo6a.randomColor(),
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
