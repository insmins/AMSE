

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
    List<double> param = [0.5,0.33,0.25,0.2,0.167,0.1428,0.125,0.1111,0.1];

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
      body: Center(
        child: Column(
          children: [
            Center(
              child: SizedBox(
                width: 600,
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
            SizedBox(
                height: 100,
                child: Image.network('https://picsum.photos/512',
                    fit: BoxFit.cover)),
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

    );
  }

  Widget _getTile(int index, Tile tile, double param) {

    return Center(
      child: Column(
        children: [
          SizedBox(
            /*width: 50.0,
            height: 50.0,*/
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
