import 'dart:convert';

import 'package:bukuta_poultry/books/models/book.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BooksController extends ChangeNotifier {
  List<Book> _books = [];

  init() async {
    var jsnDt = await rootBundle.loadString("assets/books/books.json");
    List data = json.decode(jsnDt);

    for (int i = 0; i < data.length; i++) {
      this._books.add(Book.fromMap(data[i]));
    }

    notifyListeners();
  }

  get books => _books;
}
