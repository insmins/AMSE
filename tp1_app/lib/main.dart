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
  new Book("Les Misérables", "Victor Hugo", "Classiques", false, "Chef-d'œuvre de la littérature française qui raconte l'histoire de Jean Valjean et de ses luttes pour la rédemption.", "assets/img/miserables.jpg"),
  new Book("Orgueil et Préjugés", "Jane Austen", "Classiques", false, "Un roman de comédie romantique qui explore les conventions sociales de l'Angleterre du XIXe siècle.", "assets/img/orgueil.jpeg"),
  new Book("1984", "George Orwell", "Classiques", false, "Un roman dystopique visionnaire qui dépeint un monde totalitaire où la pensée est contrôlée et la liberté est réprimée.", "assets/img/1984.jpg"),
  new Book("Le Comte de Monte-Cristo", "Alexandre Dumas", "Classiques", false, "Une histoire de vengeance et de justice personnelle dans laquelle Edmond Dantès cherche à se venger de ceux qui l'ont trahi.", "assets/img/monte_cristo.jpeg"),
  new Book("Crime et Châtiment", "Fiodor Dostoïevski", "Classiques", false, "Un roman psychologique qui explore les motivations et les conséquences d'un meurtre commis par un étudiant.", "assets/img/crime_chatiment.jpg"),
  new Book("Guerre et Paix", "Léon Tolstoï", "Classiques", false, "Une fresque épique qui relate les vies de plusieurs familles nobles russes pendant la guerre napoléonienne.", "assets/img/guerre_paix.jpg"),
  new Book("Moby Dick", "Herman Melville", "Classiques", false, "Une histoire épique de chasse à la baleine qui explore les thèmes de l'obsession, de la vengeance et de la nature humaine.", "assets/img/moby.jpg"),
  new Book("Le Portrait de Dorian Gray", "Oscar Wilde", "Classiques", false, "Un roman gothique qui explore les thèmes de la vanité, de la moralité et de la corruption.", "assets/img/dorian_gray.jpg"),
  new Book("Jane Eyre", "Charlotte Brontë", "Classiques", false, "L'histoire d'une jeune gouvernante qui trouve l'amour et l'indépendance malgré les obstacles de la société victorienne.", "assets/img/jane_eyre.jpg"),
  new Book("Les Hauts de Hurlevent", "Emily Brontë", "Classiques", false, "Un roman de passion et de vengeance qui explore les relations tumultueuses entre les membres de la famille Earnshaw.", "assets/img/hauts_hurlevent.jpeg"),

  new Book("Le Mystère de la chambre jaune", "Gaston Leroux", "Policiers", false, "Un classique du mystère qui met en scène le détective Joseph Rouletabille enquêtant sur une chambre close.", "assets/img/mystere_jaune.jpg"),
  new Book("Meurtre dans un jardin indien", "Vikram Chandra", "Policiers", false, "Un polar noir qui explore les bas-fonds de la société indienne à travers l'enquête sur un meurtre brutal.", "assets/img/meurtre_dans.jpg"),
  new Book("La Mort dans les nuages", "Agatha Christie", "Policiers", false, "Un mystère classique mettant en vedette Hercule Poirot enquêtant sur le meurtre d'une passagère dans un avion.", "assets/img/mort_nuages.jpg"),
  new Book("Millénium, tome 1 : Les Hommes qui n'aimaient pas les femmes", "Stieg Larsson", "Policiers", false, "Le premier livre d'une trilogie qui suit le journaliste Mikael Blomkvist et la hackeuse Lisbeth Salander dans une enquête sur une famille dysfonctionnelle.", "assets/img/millenium.jpg"),
  new Book("La Lune était noire", "Michael Connelly", "Policiers", false, "Un thriller captivant qui suit l'enquête du détective Harry Bosch sur un meurtre lié à une conspiration politique.", "assets/img/lune_noire.jpeg"),
  new Book("La Fille du train", "Paula Hawkins", "Policiers", false, "Un thriller psychologique qui suit une femme perturbée enquêtant sur la disparition d'une jeune femme qu'elle observe depuis son train.", "assets/img/fille_train.jpg"),
  new Book("Le Silence des agneaux", "Thomas Harris", "Policiers", false, "Un thriller glaçant mettant en scène l'agent du FBI Clarice Starling et le psychopathe Hannibal Lecter dans une traque mortelle.", "assets/img/silence_agneaux.jpg"),
  new Book("La Neige était sale", "Georges Simenon", "Policiers", false, "Un roman noir qui explore les bas-fonds de Paris pendant l'Occupation nazie, mettant en scène un homme en quête de rédemption.", "assets/img/neige_sale.jpg"),
  new Book("Le Chien des Baskerville", "Arthur Conan Doyle", "Policiers", false, "Une enquête classique de Sherlock Holmes qui explore les superstitions et les mystères entourant la mort d'un homme dans les landes du Devon.", "assets/img/chien_baskerville.jpg"),
  new Book("La Nuit du renard", "Mary Higgins Clark", "Policiers", false, "Un thriller palpitant mettant en scène une journaliste enquêtant sur une série de meurtres attribués à un tueur en série célèbre.", "assets/img/neige_renard.jpg"),

  new Book("Fondation", "Isaac Asimov", "Science-fiction", false, "Le premier livre d'une série épique qui explore l'effondrement d'une civilisation galactique et les efforts pour la reconstruire.", "assets/img/fondation.jpg"),
  new Book("Dune", "Frank Herbert", "Science-fiction", false, "Un roman de science-fiction épique qui se déroule sur la planète désertique de Arrakis, où se disputent le contrôle de l'épice, la ressource la plus précieuse de l'univers.", "assets/img/dune.jpg"),
  new Book("Neuromancien", "William Gibson", "Science-fiction", false, "Un roman cyberpunk visionnaire qui explore les thèmes de la réalité virtuelle, de l'intelligence artificielle et de la contre-culture.", "assets/img/neuromancien.jpg"),
  new Book("Le Meilleur des mondes", "Aldous Huxley", "Science-fiction", false, "Un roman dystopique qui dépeint une société futuriste où la science et la technologie ont éliminé la douleur et la souffrance, mais au prix de la liberté et de l'individualité.", "assets/img/meilleur_mondes.jpg"),
  new Book("Fahrenheit 451", "Ray Bradbury", "Science-fiction", false, "Un classique de la dystopie qui explore les dangers de la censure et de la société de la télévision, où les pompiers brûlent les livres interdits.", "assets/img/fahrenheit_451.jpg"),
  new Book("Ubik", "Philip K. Dick", "Science-fiction", false, "Un roman métaphysique qui explore les thèmes de la réalité, de l'identité et de la perception à travers une histoire de voyages dans le temps et de manipulation de la réalité.", "assets/img/ubik.jpg"),
  new Book("Le Guide du voyageur galactique", "Douglas Adams", "Science-fiction", false, "Dans une galaxie chaotique, le terrien Arthur Dent est emmené dans une aventure interstellaire hilarante après que la Terre ait été détruite pour faire place à une autoroute hyperspatiale.", "assets/img/guide_voyageur.jpg"),
  new Book("La Guerre éternelle", "Joe Haldeman", "Science-fiction", false, "Un roman de science-fiction militaire qui suit les soldats humains dans une guerre interstellaire contre une espèce extraterrestre.", "assets/img/guerre_eternelle.jpg"),
  new Book("Les androïdes rêvent-ils de moutons électriques ?", "Philip K. Dick", "Science-fiction", false, "Le roman qui a inspiré le film Blade Runner, explorant les thèmes de l'identité, de la conscience et de l'humanité à travers une dystopie post-apocalyptique.", "assets/img/androides_electriques.jpg"),
  new Book("Solaris", "Stanisław Lem", "Science-fiction", false, "Un roman philosophique qui se déroule sur une planète océanique étrange où les explorateurs humains sont confrontés à des manifestations de leurs propres psychés.", "assets/img/solaris.jpg"),
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
