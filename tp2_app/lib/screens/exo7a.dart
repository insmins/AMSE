
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2_app/screens/exo4.dart';


import 'exo7b.dart';

class Exo7a extends StatefulWidget {

  const Exo7a({super.key});

  @override
  State<Exo7a> createState() => _Exo7aState();
}


Widget createTileWidgetFrom(Tile tile, double param, BuildContext context) {
  return InkWell(
    child: tile.croppedImageTile(param,param), // a changer
  );
}


class _Exo7aState extends State<Exo7a> {
  double _currentSliderValue = 3.0;
  double _levelOfShuffle = 1;

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
  double generateParam(double currentSliderValue){
    double param;
    param = (1/_currentSliderValue);
    return param;
  }


  @override
  Widget build(BuildContext context) {

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
    List.generate(
      tileAlignements.length,
          (index) => widgetTiles.add( _getTile(tile[index],param)),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Plateau de tuiles'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child:
          Center(
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: 380,
                    height: 380,
                    child: GridView.count(
                      padding: const EdgeInsets.all(20),
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 1,
                      crossAxisCount: _currentSliderValue.toInt(),
                      children: widgetTiles,
                    ),
                  ),
                ),
                Center(
                      child: SizedBox(
                        width: 331,
                        child: Column(
                          children: [
                              Row(
                                children: [
                                  const Text(
                                    'Choisir une\n difficulté',
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
                            Row(
                              children: [
                                const Text(
                                  'Niveau de  \n mélange',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: 250,
                                  height: 100,
                                  child: Slider(
                                    value: _levelOfShuffle,
                                    min: 1,
                                    max: 5,
                                    divisions: 5,
                                    label: _levelOfShuffle.round().toString(),
                                    onChanged: (double value) {
                                      setState(() {
                                        _levelOfShuffle = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 90,
                                child: FloatingActionButton(
                                    onPressed: () {Navigator.push(context, MaterialPageRoute(
                                      builder: (context) => Exo7b(tiles: widgetTiles,numberOfRows: _currentSliderValue,levelOfShuffle: _levelOfShuffle),
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
                          ],
                        ),
                      ),
                    ),


              ],
            ),
          ),
        ),
      ),

    );
  }

  Widget _getTile(Tile tile, double param) {
    return Container(
        child: createTileWidgetFrom(tile, param,context)
    );
  }


}

