import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Exo1 extends StatelessWidget {
  const Exo1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: const Text('Display an Image'),
        centerTitle: true,
      ),
        body : const Center(
          child : SingleChildScrollView(
            child: Image(
            image: NetworkImage("https://picsum.photos/512/1024"),
                    ),
          ),
        ),
    );
  }
}