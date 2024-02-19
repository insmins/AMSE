

import 'package:flutter/material.dart';
import 'package:tp2_app/screens/exo4.dart';

class Exo5 extends StatefulWidget {
  const Exo5({Key? key});

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
    List <double> generateParam (double currentSliderValue){
      List <double> param = [];
      param.add(1/_currentSliderValue);
      return param;
    }
    List<double> param = generateParam(_currentSliderValue);

    List<Alignment> tileAlignements = generateTileAlignments(_currentSliderValue);


    List<Tile> tile = [];
    for (int i = 0; i < tileAlignements.length; i++) {
      //on créé tout les tiles
      tile.add(Tile(imageURL: 'https://picsum.photos/512', alignment: tileAlignements[i]));

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
                            (index) => Container(
                          child: _getTile(index, tile[index], param[_currentSliderValue.toInt()-2]),
                        ),
                      ),
                    ),
                  ),
                ),

                Center(
                  child: SizedBox(
                    width: 350,
                    height: 100,
                      child: Row(
                        children: [
                          const Text(
                            'Size',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          SizedBox(
                            width: 300,
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
                  ),
              ],
            ),
          ),
      ),

    );
  }

  Widget _getTile(int index, Tile tile, double param) {

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
