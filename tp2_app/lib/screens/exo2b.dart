import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Exo2b extends StatefulWidget {
  const Exo2b({super.key});

  @override
  State<Exo2b> createState() => _Exo2bState();
}

class _Exo2bState extends State<Exo2b> {
  double _sliderSki = 0.0;
  double _sliderHorloge = 0.0;
  double _sliderDepl = 0.0;
  bool flagSliderSki = true;
  bool flagSliderDepl = true;
  bool flagSliderHorloge = true;

  @override
  Widget build(BuildContext context) {
    void animate(Timer t){
      setState(() {
        if (1-0.05 < _sliderSki) {
          flagSliderSki = false;
        }
        else if (_sliderSki < 0+0.05) {
          flagSliderSki = true;
        }
        _sliderSki = flagSliderSki?_sliderSki+0.1:_sliderSki-0.1;

        if (_sliderDepl > 100-2) {
          flagSliderDepl = false;
        }
        else if (_sliderDepl < 0+1) {
          flagSliderDepl = true;
        }
        _sliderDepl = flagSliderDepl?_sliderDepl+2:_sliderDepl-2;

        if (_sliderHorloge > 2*pi-pi/8) {
          flagSliderHorloge = false;
        }
        else if (_sliderHorloge < 0+pi/8) {
          flagSliderHorloge = true;
        }
        _sliderHorloge = flagSliderHorloge?_sliderHorloge+pi/8:_sliderHorloge-pi/8;
      });
      t.cancel();
    }

    const d = const Duration(milliseconds: 100);
    Timer timer = new Timer.periodic(d, animate);

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
              Text("Cisaillement"+pi.toString()),
            ]
            ),
            Row(children: [
              Slider(
                value: _sliderHorloge,
                max: 2*pi,
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
                max: 100,
                divisions: 50,
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

