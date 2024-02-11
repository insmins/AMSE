import 'package:flutter/material.dart';
import 'package:TP1_app/models/book.dart';

class Favorites extends ChangeNotifier {
  final List<Book> _favoriteBooks = [];

  List<Book> get books => _favoriteBooks;

  void add(int itemNo) {
    _favoriteBooks.add(itemNo);
    notifyListeners();
  }

  void remove(int itemNo) {
    _favoriteBooks.remove(itemNo);
    notifyListeners();
  }
}
