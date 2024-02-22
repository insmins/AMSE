
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2_app/screens/exo4.dart';
import 'package:tp2_app/screens/exo2.dart';

class Exo5b extends StatefulWidget {
  final bool isVisible;
  const Exo5b({super.key, required this.isVisible});

  @override
  State<Exo5b> createState() => _Exo5bState();
}


Widget createTileWidgetFrom(Tile tile, double param, BuildContext context) {
  return InkWell(
    child: tile.croppedImageTile(param,param), // a changer
    onTap: () {
      print("Tuile tapée !");
    },
  );
}


class _Exo5bState extends State<Exo5b> {

  double _currentSliderValue = 3.0;

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
    return Container(
        child: createTileWidgetFrom(tile, param,context)
    );
  }


}

