import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class exo2 extends StatefulWidget {
  const exo2({super.key});

  @override
  State<exo2> createState() => _exo2State();
}

class _exo2State extends State<exo2> {
  double _currentSliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transformation d\'images')),
      body: Column(
        children:[
          Image(image: NetworkImage("https://picsum.photos/512/1024")),
          Slider(
            value: _currentSliderValue,
            max: 100,
            divisions: 5,
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
            },
          ),
        ]
      ),
    );
  }
}