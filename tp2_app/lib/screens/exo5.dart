
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2_app/screens/exo4.dart';
import 'package:tp2_app/screens/exo2.dart';

class Exo5 extends StatefulWidget {
  final bool isVisible;
  const Exo5({super.key, required this.isVisible});

  @override
  State<Exo5> createState() => _Exo5State();
}

class _Exo5State extends State<Exo5> {

  double _currentSliderValue = 3.0;


  @override
  Widget build(BuildContext context) {

    List<Alignment> generateTileAlignments(double sliderValue) {
      int gridSize = sliderValue.toInt(); // Convertir en entier, car le sliderValue est de type double
      List<Alignment> tileAlignments = [];

      for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < gridSize; j++) {
          double x = -1.0 + (2.0 / (gridSize - 1)) * j;
          double y = -1.0 + (2.0 / (gridSize - 1)) * i;
          tileAlignments.add(Alignment(x, y));
        }
      }

      return tileAlignments;
    }
    double generateParam (double currentSliderValue){
      double param;
      param = (1/_currentSliderValue);
      return param;
    }
    double param = generateParam(_currentSliderValue);

    List<Alignment> tileAlignements = generateTileAlignments(_currentSliderValue);


    List<Tile> tile = [];
    for (int i = 0; i < tileAlignements.length; i++) {
      //on créé tout les tiles
      tile.add(Tile(imageURL: 'https://picsum.photos/512',
          alignment: tileAlignements[i]));
    }

    // on fait une liste avec les widgetTiles (portion de l'image) grâce à _getTiles
    List <Widget> widgetTiles = [];
      for (int i = 0; i < tile.length; i++) {
        widgetTiles.add(_getTile(tile[i],param));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plateau de tuiles'),
      ),
      body: SingleChildScrollView(
        child:
          Center(
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 380,
                    height: 380,
                    child: GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      crossAxisCount: _currentSliderValue.toInt(),

                      childAspectRatio:1, // a changer
                      children: List.generate(
                        tileAlignements.length,
                            (index) => FloatingActionButton(
                              onPressed: () {Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Exo2(),
                              ));},
                              child: Container(
                                                        child: widgetTiles[index],
                                                      ),
                            ),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: SizedBox(
                    width: 320,
                    height: 200,
                      child: Column(
                        children: [
                          Center(
                            child: Row(
                                  children: [
                                    const Text(
                                      'Choisir une \n difficulté',
                                      style: TextStyle(
                                        fontSize: 11.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),

                                    SizedBox(
                                      width: 250,
                                      height: 100,
                                      child: Slider(
                                        value: _currentSliderValue,
                                        min: 2,
                                        max: 10,
                                        divisions: 8,
                                        label: _currentSliderValue.round().toString(),
                                        onChanged: (double value) {
                                          setState(() {
                                            _currentSliderValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                          SizedBox(
                            width: 90,
                            child: Visibility(
                              visible: widget.isVisible,
                              child: FloatingActionButton(
                                  onPressed: () {Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Exo2(),
                                  ));},
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Icon(Icons.play_arrow),
                                        Text(" Jouer")
                                      ],
                                    ),
                                  )
                              ),
                            
                            ),
                          ),
                        ],
                      ),

                      ),
                  ),
              ],
            ),
          ),
      ),

    );
  }

  Widget _getTile(Tile tile, double param) {

    return Center(
      child: Column(
        children: [
          SizedBox(
            child: Container(
              child: createTileWidgetFrom(tile, param)
            )
    ),
    ],
    ),
    );
  }

  Widget createTileWidgetFrom(Tile tile, double param) {
    return InkWell(
      child: tile.croppedImageTile(param,param), // a changer
      onTap: () {
        print("La tuile a été tapée !");
      },
    );
  }
}
