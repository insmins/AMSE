// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:TP1_app/models/book.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:TP1_app/models/favorites.dart';
import 'package:TP1_app/screens/about.dart';
import 'package:TP1_app/screens/favorites.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';
  final List<Book> livres;

  const HomePage(this.livres, {super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = MediaPage(widget.livres);
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = AboutPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Theme
                  .of(context)
                  .colorScheme
                  .primaryContainer,
              child: page, // ← Here.
            ),
          ),
          NavigationBar(
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Icons.view_headline_sharp),
                label: 'About',
              ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: (value) {
              setState(() {
                selectedIndex = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

class ItemTile extends StatefulWidget {
  final Book livre;

  const ItemTile(this.livre, {super.key});

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  final int itemNo = 0;

  @override
  Widget build(BuildContext context) {
    final favoritesList = context.watch<Favorites>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Tooltip(
        child: ListTile(
          leading:  ClipRRect(
            borderRadius: const BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Image(
              image: AssetImage(widget.livre.imgUrl ?? ""),
              fit: BoxFit.cover,
              height: 150.0,
            ),
          ),
          title: Text(
            widget.livre.title.replaceAll(r'\', ''),
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle:
          Text(
            'Auteur: ${widget.livre.author} ',
            style: const TextStyle(
              fontSize: 12.0,
            ),
          ),
          trailing: IconButton(
                key: Key('icon_${itemNo}'),
                icon: favoritesList.items.contains(widget.livre)
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                onPressed: () {
                  !favoritesList.items.contains(widget.livre)
                      ? favoritesList.add(widget.livre)
                      : favoritesList.remove(widget.livre);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(favoritesList.items.contains(widget.livre)
                          ? 'Added to favorites.'
                          : 'Removed from favorites.'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
              ),
          ),
        message: "Titre : " + widget.livre.title + "\nAuteur : " + widget.livre.author + "\nDescription : " + widget.livre.desc,
      ),
    );
  }
}

class MediaPage extends StatefulWidget {
  final List<Book> livres;
  const MediaPage(this.livres, {super.key});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Book> classiques = [];
    List<Book> policiers = [];
    List<Book> sf = [];
    for(int i = 0; i < widget.livres.length; i++){
      switch(widget.livres[i].category){
        case "Classiques":
          classiques.add(widget.livres[i]);
          break;
        case "Policiers":
          policiers.add(widget.livres[i]);
          break;
        case "Science-fiction":
          sf.add(widget.livres[i]);
          break;
      }
    }

    Widget listview_c = ListView.builder(
      itemCount: classiques.length,
      cacheExtent: 20.0,
      controller: ScrollController(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) => ItemTile(
          classiques[index]
      ),
    );

    Widget listview_p = ListView.builder(
      itemCount: policiers.length,
      cacheExtent: 20.0,
      controller: ScrollController(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) => ItemTile(
          policiers[index]
      ),
    );

    Widget listview_s = ListView.builder(
      itemCount: sf.length,
      cacheExtent: 20.0,
      controller: ScrollController(),
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemBuilder: (context, index) => ItemTile(
          sf[index]
      ),
    );

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Livres'),
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.book_rounded),
                  text: "Classiques",
                ),
                Tab(
                  icon: Icon(Icons.local_police),
                  text: "Policiers",
                ),
                Tab(
                  icon: Icon(Icons.rocket_launch),
                  text: "Science-Fiction",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              listview_c,
              listview_p,
              listview_s,
            ],
          ),
        ),
    );
  }
}
