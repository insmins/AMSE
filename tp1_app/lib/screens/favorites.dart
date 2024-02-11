// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:TP1_app/models/favorites.dart';
import 'package:TP1_app/models/book.dart';

class FavoritesPage extends StatelessWidget {
  static const routeName = 'favorites_page';
  static const fullPath = '/$routeName';

  const FavoritesPage({super.key}); // appelle constructeur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoris'),
      ),
      body: Consumer<Favorites>(
        builder: (context, value, child) => value.items.isNotEmpty
            ? ListView.builder(
                itemCount: value.items.length,
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemBuilder: (context, index) =>
                    FavoriteItemTile(book: value.items[index]),
              )
            : const Center(
                child: Text('No favorites added.'),
              ),
      ),
    );
  }
}

class FavoriteItemTile extends StatelessWidget {
  final Book book;

  FavoriteItemTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return  Row(
          children: <Widget>[
            // image colonne
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
                child: Image(
                  image: AssetImage(book.imgUrl ?? ""),
                  fit: BoxFit.cover,
                  height: 150.0,
              ),
            ),
            const SizedBox(width: 10.0), // espace entre les colonnes
            // Colonne pour les info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 5.0),
                        child: Text(
                          book.title.replaceAll(r'\', ''),
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Auteur: ${book.author}',
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'Catégorie: ${book.category}',
                    style: const TextStyle(
                      fontSize: 12.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Colonne
            IconButton(
              key: Key('remove_icon_${book.title}'),
              icon: const Icon(Icons.close),
              onPressed: () {
                // Logique pour supprimer le livre des favoris
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Enlevé des favoris'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
          ],
    );
  }

}





