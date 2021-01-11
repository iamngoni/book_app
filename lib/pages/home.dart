import 'dart:convert';

import 'package:bukuta_poultry/utils/index.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Bukuta Poultry",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
