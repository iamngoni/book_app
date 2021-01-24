import 'package:bukuta_poultry/state/cart.dart';
import 'package:bukuta_poultry/state/products.dart';
import 'package:bukuta_poultry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Product extends StatefulWidget {
  String productName;
  Product({this.productName});
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: dimension.height,
        width: dimension.width,
        child: Consumer<ProductsController>(
          builder: (context, product, child) {
            var selectedProduct =
                product.productByName(this.widget.productName);
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Hero(
                          tag: selectedProduct.name,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(8.0),
                            height: dimension.kHeight(0.3),
                            width: dimension.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                              image: DecorationImage(
                                image: AssetImage(selectedProduct.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          child: GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              height: 30,
                              width: 30,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.arrow_back,
                                size: 20,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.favorite_outline,
                              color: kGrey,
                              size: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${selectedProduct.name} - ${selectedProduct.state}",
                            style: TextStyle(
                              color: kDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            selectedProduct.weight ?? "n/a",
                            style: TextStyle(
                              color: kOrange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Free Delivery",
                                style: TextStyle(
                                  color: kDark,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.watch_later_outlined,
                                color: kGrey,
                              ),
                            ],
                          ),
                          Container(
                            child: Text("Bukuta Poultry"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(color: kGrey),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "Info",
                        style: TextStyle(
                          color: kDark,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(color: kGrey),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.check,
                              color: kOrange,
                            ),
                            title: Text("Large Size"),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.check,
                              color: kOrange,
                            ),
                            title: Text("Healthy"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 100,
                    width: dimension.width,
                    child: Card(
                      color: Colors.white,
                      elevation: 25.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "\$${selectedProduct.price}",
                            style: TextStyle(
                              color: kDark,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: kOrange,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: MaterialButton(
                              onPressed: () {
                                Provider.of<CartController>(context,
                                        listen: false)
                                    .addItemToCart(selectedProduct);
                              },
                              child: Text(
                                "Add To Card",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
