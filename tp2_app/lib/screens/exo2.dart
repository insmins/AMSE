import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exo2 extends StatefulWidget {
  const Exo2({super.key});

  @override
  State<Exo2> createState() => _Exo2State();
}

class _Exo2State extends State<Exo2> {
  double _sliderSki = 0.0;
  double _sliderHorloge = 0.0;
  double _sliderDepl = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transformation d\'images')),
      body: SingleChildScrollView(
        padding:const EdgeInsets.only(top: 50, bottom: 30),
        child: Column(
          children:[
            SizedBox(
              height: 400,
              width: 200,
              child: Transform(
                transform: Matrix4.skewY(_sliderSki)..rotateZ(_sliderHorloge)..leftTranslate(_sliderDepl),
                alignment: Alignment.center,
                  child: const Image(
                      image: ResizeImage(
                          NetworkImage("https://picsum.photos/512/1024"),
                          height: 192,
                          width: 108,
                      )

                ),
              ),
            ),
            Row(children: [
              Slider(
                value: _sliderSki,
                max: 1,
                divisions: 10,
                label: _sliderSki.toString(),
                onChanged: (double value) {
                  setState(() {
                    _sliderSki = value;
                  });
                },
              ),
              Text("Cisaillement"),
            ]
            ),
            Row(children: [
              Slider(
                value: _sliderHorloge,
                max: 6.28,
                divisions: 16,
                label: _sliderHorloge.toString(),
                onChanged: (double value) {
                  setState(() {
                    _sliderHorloge = value;
                  });
                },
              ),
              Text("Rotation"),
            ]
            ),
            Row(children: [
              Slider(
                value: _sliderDepl,
                max: 30,
                divisions: 15,
                label: _sliderDepl.toString(),
                onChanged: (double value) {
                  setState(() {
                    _sliderDepl = value;
                  });
                },
              ),
              Text("Translation"),
            ]
            ),
          ]
        ),
      ),
    );
  }
}