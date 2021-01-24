import 'dart:convert';

import 'package:bukuta_poultry/pages/about.dart';
import 'package:bukuta_poultry/pages/cart.dart';
import 'package:bukuta_poultry/pages/favourites.dart';
import 'package:bukuta_poultry/pages/product.dart';
import 'package:bukuta_poultry/pages/products.dart';
import 'package:bukuta_poultry/state/products.dart';
import 'package:bukuta_poultry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _pages = [HomePage(), Favourites(), Cart(), About()];
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductsController>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Favourites",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: "About",
          )
        ],
        currentIndex: _index,
        onTap: (int index) {
          setState(() {
            this._index = index;
          });
        },
        unselectedItemColor: kGrey,
        selectedItemColor: kOrange,
        showUnselectedLabels: false,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1.0,
        // leading: Icon(
        //   Icons.menu,
        //   color: Colors.black,
        // ),
        backgroundColor: Colors.white,
        title: Text(
          "Bukuta Poultry",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: dimension.height,
            width: dimension.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                  "What would you like to order ?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: kDark,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Search birds",
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 35,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Categories",
                      style: TextStyle(
                        color: kDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "View All",
                      style: TextStyle(
                        color: kGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString("assets/categories/categories.json"),
                  builder: (context, snapshot) {
                    while (!snapshot.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List data = json.decode(snapshot.data);
                    return Container(
                      color: Colors.white,
                      height: dimension.kHeight(0.2),
                      width: dimension.width,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: data
                            .map(
                              (category) => Container(
                                height: dimension.kHeight(0.2),
                                width: dimension.kWidth(0.15),
                                child: Card(
                                  elevation: 5.0,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(category["image"]),
                                          height: 60,
                                          width: 70,
                                        ),
                                        Text(
                                          category["name"],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Popular",
                      style: TextStyle(
                        color: kDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Products(),
                        ),
                      ),
                      child: Text(
                        "View All",
                        style: TextStyle(
                          color: kGrey,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Consumer<ProductsController>(
                  builder: (context, products, child) {
                    return Container(
                      height: dimension.kHeight(0.4),
                      width: dimension.width,
                      child: GridView.count(
                        crossAxisCount: 2,
                        children: products.popular.map(
                          (product) {
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              width: dimension.width,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => Product(
                                        productName: product.name,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  elevation: 7.0,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Hero(
                                        child: Image(
                                          image: AssetImage(product.image),
                                          height: dimension.kHeight(0.4) * 0.21,
                                          width: dimension.kWidth(0.4),
                                          fit: BoxFit.fill,
                                        ),
                                        tag: product.name,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: dimension.kWidth(0.15),
                                              child: Text(
                                                "${product.name} - ${product.state}",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: kDark,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Text(
                                              product.weight ?? "n/a",
                                              style: TextStyle(
                                                color: kGrey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 5.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Free Delivery",
                                              style: TextStyle(
                                                color: kGrey,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "\$${product.price}",
                                              style: TextStyle(
                                                color: kOrange,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "Bukuta Poultry - 2021",
                    style: TextStyle(
                      color: kDark,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
