import 'package:bukuta_poultry/books/pages/home.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BooksHome(),
              ),
            ),
            child: Text("Books"),
          ),
        ],
      ),
    );
  }
}
