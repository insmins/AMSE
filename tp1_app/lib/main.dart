// Copyright 2020 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:TP1_app/models/favorites.dart';
import 'package:TP1_app/screens/favorites.dart';
import 'package:TP1_app/screens/home.dart';

import 'models/book.dart';

void main() {
  runApp(const TestingApp());
}

List<Book> livres =
[
  new Book("livre classique 1", "_author", "Classiques", false, "_desc"),
  new Book("livre policier 1", "_author", "Policiers", false, "_desc"),
  new Book("livre classique deux", "_author", "Classiques", false, "_desc")
];

GoRouter router() {
  return GoRouter(
    routes: [
      GoRoute(
        path: HomePage.routeName,
        builder: (context, state) => HomePage(livres),
        routes: [
          GoRoute(
            path: FavoritesPage.routeName,
            builder: (context, state) => const FavoritesPage(),
          ),
        ],
      ),
    ],
  );
}

class TestingApp extends StatelessWidget {
  const TestingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favorites>(
      create: (context) => Favorites(),
      child: MaterialApp.router(
        title: 'Testing Sample',
        theme: ThemeData(
          colorSchemeSeed: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          useMaterial3: true,
        ),
        routerConfig: router(),
      ),
    );
  }
}
