import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exo1 extends StatelessWidget {
  const Exo1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: NetworkImage("https://picsum.photos/512/1024"),
    );
  }
}