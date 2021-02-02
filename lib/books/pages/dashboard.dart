import 'package:bukuta_poultry/books/controllers/books_controller.dart';
import 'package:bukuta_poultry/books/models/book.dart';
import 'package:bukuta_poultry/books/utils/index.dart';
import 'package:bukuta_poultry/utils/custom_icons.dart';
import 'package:bukuta_poultry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
    Provider.of<BooksController>(context, listen: false).init();
  }

  List _categories = ["Best Seller", "The Latest", "Coming Soon"];
  int _categoriesIndex = 0;

  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return SingleChildScrollView(
      child: Container(
        height: dimension.height,
        width: dimension.width,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              margin: EdgeInsets.only(
                left: 20.0,
                right: 20.0,
                top: 20.0,
                bottom: 5.0,
              ),
              child: Text(
                "Good Evening",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Ngonidzashe Mangudya",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    pointsContainer(
                      points: 240,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: actionsCard()),
            SizedBox(height: 25),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "My Book",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "see more",
                    style: TextStyle(
                      color: topCardColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(
                left: 20.0,
              ),
              child: booksList(
                height: dimension.kHeight(0.35),
                width: dimension.width,
              ),
            ),
            SizedBox(height: 25),
            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: categories()),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(
                left: 20.0,
              ),
              child: booksListAlt(
                height: dimension.height,
                width: dimension.width,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pointsContainer({@required int points}) {
    return Container(
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: orange,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 25,
            width: 25,
            decoration: BoxDecoration(
              color: deepOrange,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: customIcon(
                path: "assets/icons/variable-1784383.png",
                size: 15,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            "$points point",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget actionsCard() {
    return Container(
      decoration: BoxDecoration(
        color: topCardColorAlt,
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          topCardActions(
            path: "assets/icons/create-dashboard-1881214.png",
            actionText: "Claim",
          ),
          verticalDivider(),
          topCardActions(
            path: "assets/icons/archery-1214352.png",
            actionText: "Get Point",
          ),
          verticalDivider(),
          topCardActions(
            path: "assets/icons/atm-card-1218378.png",
            actionText: "My Card",
          ),
        ],
      ),
    );
  }

  Widget topCardActions({@required String path, @required String actionText}) {
    return Row(
      children: [
        customIcon(
          path: path,
          size: 20,
          color: orange,
        ),
        SizedBox(width: 7.0),
        Text(
          actionText,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget verticalDivider() {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 20,
      ),
      width: 1.0,
      color: topCardColor,
    );
  }

  Widget booksList({@required double height, @required double width}) {
    return Container(
      height: height,
      width: width,
      child: Consumer<BooksController>(
        builder: (context, booksController, child) {
          while (booksController.books.length < 1) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: orange,
              ),
            );
          }
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: booksController.books.length,
            itemBuilder: (context, index) {
              return bookCard(
                book: booksController.books[index],
                width: width * 0.20,
                height: height,
              );
            },
          );
        },
      ),
    );
  }

  Widget bookCard(
      {@required Book book, @required double width, @required height}) {
    return Container(
      margin: EdgeInsets.only(
        right: 14.0,
      ),
      width: width,
      child: Column(
        children: [
          book.image != null
              ? Container(
                  height: height * 0.8,
                  width: width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(book.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(
                      15.0,
                    ),
                    border: Border.all(
                      color: topCardColorAlt,
                    ),
                  ),
                )
              : Container(
                  height: height * 0.8,
                  width: width,
                  child: Center(
                    child: Text(
                      "No Image",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: Row(
              children: [
                bookStatsTime(
                  book: book,
                ),
                SizedBox(
                  width: 15.0,
                ),
                bookStatsCompletion(
                  book: book,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bookStatsTime({@required Book book}) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: topCardColor,
        ),
        SizedBox(width: 5.0),
        Text(
          book.added_at,
          style: TextStyle(
            color: topCardColor,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget bookStatsCompletion({@required Book book}) {
    return Row(
      children: [
        Icon(
          Icons.layers_outlined,
          color: topCardColor,
        ),
        SizedBox(width: 5.0),
        Text(
          "${book.reading}%",
          style: TextStyle(
            color: topCardColor,
            fontWeight: FontWeight.w100,
          ),
        ),
      ],
    );
  }

  Widget categories() {
    return Row(
      children: _categories
          .map(
            (category) => Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
              ),
              child: GestureDetector(
                onTap: () => setState(() {
                  _categoriesIndex = _categories.indexOf(category);
                }),
                child: Text(
                  category,
                  style: TextStyle(
                    color: _categories.indexOf(category) == _categoriesIndex
                        ? Colors.white
                        : topCardColorAlt,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget booksListAlt({@required double height, @required double width}) {
    return Container(
      width: width,
      child: Consumer<BooksController>(
        builder: (context, booksController, child) {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: booksController.books.length,
            itemBuilder: (context, index) {
              return singleBook(
                book: booksController.books[index],
                height: height,
                width: width,
              );
            },
          );
        },
      ),
    );
  }

  Widget singleBook({@required Book book, @required height, @required width}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          book.image != null
              ? Container(
                  height: height * 0.17,
                  width: width * 0.15,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(book.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: topCardColorAlt,
                    ),
                  ),
                )
              : Container(
                  height: height * 0.17,
                  width: width * 0.15,
                  child: Center(
                    child: Text(
                      "No image",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
          SizedBox(
            width: 12.0,
          ),
          Container(
            height: height * 0.17,
            width: width * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      book.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    customIcon(
                      path: "assets/icons/save-1214293.png",
                      size: 25.0,
                    ),
                  ],
                ),
                Text(
                  book.author,
                  style: TextStyle(
                    color: topCardColor,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    pagesNo(
                      book: book,
                    ),
                    SizedBox(width: 10.0),
                    bookRating(
                      book: book,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: book.categories
                      .split(",")
                      .map(
                        (category) => categoryBadge(
                          category: category,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget pagesNo({@required Book book}) {
    return Row(
      children: [
        customIcon(
          path: "assets/icons/layer-1214322.png",
          size: 20.0,
          color: topCardColor,
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          "${book.pages}p",
          style: TextStyle(
            color: topCardColor,
          ),
        ),
      ],
    );
  }

  Widget bookRating({@required Book book}) {
    return Row(
      children: [
        customIcon(
          path: "assets/icons/star-1214288.png",
          size: 20.0,
          color: topCardColor,
        ),
        SizedBox(
          width: 3.0,
        ),
        Text(
          "${double.parse(book.rating.toString())}",
          style: TextStyle(
            color: topCardColor,
          ),
        ),
      ],
    );
  }

  Widget categoryBadge({@required category}) {
    return Container(
      padding: EdgeInsets.all(7.0),
      margin: EdgeInsets.only(
        right: 10.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.0),
        color: getColor(category)["backColor"],
      ),
      child: Text(
        category,
        style: TextStyle(
          color: getColor(category)["color"],
        ),
      ),
    );
  }

  Map<String, Color> getColor(String category) {
    Color color;
    Color backColor;
    switch (category.trim()) {
      case "Drama":
        color = purple;
        backColor = navyBlue;
        break;
      case "Romance":
        color = red;
        backColor = maroon;
        break;
      case "Adventure":
        color = green;
        backColor = deepGreen;
        break;
    }

    return {"color": color, "backColor": backColor};
  }
}
