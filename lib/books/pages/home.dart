import 'package:bukuta_poultry/books/pages/index.dart';
import 'package:bukuta_poultry/books/utils/index.dart';
import 'package:bukuta_poultry/utils/custom_icons.dart';
import 'package:flutter/material.dart';

class BooksHome extends StatefulWidget {
  @override
  _BooksHomeState createState() => _BooksHomeState();
}

class _BooksHomeState extends State<BooksHome> {
  List pages = [
    Dashboard(),
    Search(),
    Notifications(),
    Menu(),
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundDark,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        backgroundColor: backgroundDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: customIcon(
              path: "assets/icons/chip-1214343.png",
              size: 25,
              color: _index == 0 ? Colors.white : topCardColor,
            ),
            backgroundColor: backgroundDark,
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: customIcon(
              path: "assets/icons/magnifier-1214318.png",
              size: 25,
              color: _index == 1 ? Colors.white : topCardColor,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: customIcon(
              path: "assets/icons/bell-1224695.png",
              size: 25,
              color: _index == 2 ? Colors.white : topCardColor,
            ),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu,
              color: _index == 3 ? Colors.white : topCardColor,
            ),
            label: "Menu",
          ),
        ],
      ),
      body: pages[_index],
    );
  }
}
