
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tp2_app/screens/exo4.dart';
import 'package:image_picker/image_picker.dart';


import 'exo7b.dart';
import 'galerie.dart';

class Exo7a extends StatefulWidget {
Image? imageAsset;
   Exo7a({super.key, this.imageAsset});

  @override
  State<Exo7a> createState() => _Exo7aState();
}

class _Exo7aState extends State<Exo7a> {
  double _currentSliderValue = 3.0;
  double _levelOfShuffle = 1;
  File? _image;
  final picker = ImagePicker();



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


  //Show options to get image from camera or gallery
  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: const Text('Galerie'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from gallery
              getImageFromGallery();
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Appareil photo'),
            onPressed: () {
              // close the options modal
              Navigator.of(context).pop();
              // get image from camera
              getImageFromCamera();
            },
          ),
        ],
      ),
    );
  }
//Image Picker function to get image from gallery
  Future getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("je suis dans getImage gallery");
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

//Image Picker function to get image from camera
  Future getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double param = generateParam(_currentSliderValue);
    List<Alignment> tileAlignements = generateTileAlignments(_currentSliderValue);
    print (widget.imageAsset);


    List<Tile> tile = [];
    for (int i = 0; i < tileAlignements.length; i++) {
      //on créé tout les tiles
      if (_image != null) {
        tile.add(Tile(alignment: tileAlignements[i], imagePicker: _image));

      } else if (widget.imageAsset != null) {
        tile.add(Tile(alignment:  tileAlignements[i], imageAsset: widget.imageAsset));
        print ('eee');
      } else  if ( _image == null && widget.imageAsset == null){
        print('what ??');
        tile.add(Tile(alignment: tileAlignements[i]));
      }
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
          child: Center(
            child: Column(
              children: [
                SizedBox(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            elevation: 10,
                            textStyle: const TextStyle(
                              color: Colors.white,
                            )
                        ),
                        onPressed: () {
                          showOptions();
                        },
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.photo_library,color: Color(0xfff7f1fb)),
                            ),
                            Text("Galerie",
                              style: TextStyle(color: Color(0xfff7f1fb)),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          elevation: 10,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          )
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Galerie(),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.add_to_photos,color: Color(0xfff7f1fb)),
                            ),
                            Text(
                                "Choisir une image",
                              style: TextStyle(
                                color: Color(0xfff7f1fb),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
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
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100),
                        child: SizedBox(
                          width: 90,
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Exo7b(
                                    tiles: widgetTiles,
                                    numberOfRows: _currentSliderValue,
                                    levelOfShuffle: _levelOfShuffle,
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Icon(Icons.play_arrow),
                                  Text("Jouer"),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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

  Widget createTileWidgetFrom(Tile tile, double param, BuildContext context) {
    if (_image != null) {
      return InkWell(
        child: tile.croppedImagePickerTile(param, param),
      );
    }if (widget.imageAsset != null){
      return InkWell(
        child: tile.croppedImageAssetTile(param, param),
      );
    } else {
      return InkWell(
        child: tile.croppedImageTile(param, param),
      );
    }
  }

}

