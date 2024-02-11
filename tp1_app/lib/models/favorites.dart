import 'package:flutter/material.dart';
import 'package:TP1_app/models/book.dart';

class Favorites extends ChangeNotifier {
  final List<Book> _favoriteBooks = [];

  List<Book> get items => _favoriteBooks;

  void add(Book bookToAdd) {
    _favoriteBooks.add(bookToAdd);
    notifyListeners();
  }

  void remove(Book bookToRemove) {
    _favoriteBooks.remove(bookToRemove);
    notifyListeners();
  }
}
