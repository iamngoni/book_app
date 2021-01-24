import 'package:bukuta_poultry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        centerTitle: true,
        title: Text(
          "About",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: dimension.height,
        width: dimension.width,
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Bukuta Poultry",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            Card(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        launch(
                            'https://api.whatsapp.com/send?phone=263782617420');
                      },
                      child: Text(
                        "WhatsApp: 0782617420",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.message_outlined),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Card(
              child: Container(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        launch("tel:263782617420");
                      },
                      child: Text(
                        "Calls: 0782617420",
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.call),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
