import 'package:bukuta_poultry/pages/product.dart';
import 'package:bukuta_poultry/state/products.dart';
import 'package:bukuta_poultry/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return Consumer<ProductsController>(
      builder: (context, product, child) {
        List products = product.productList;
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            centerTitle: true,
            title: Text(
              "Products",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            height: dimension.height,
            width: dimension.width,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: products
                  .map(
                    (product) => GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => Product(
                            productName: product.name,
                          ),
                        ),
                      ),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage(product.image),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(product.name),
                        subtitle: Text(product.category),
                        trailing: Text(
                          "\$${product.price}",
                          style: TextStyle(
                            color: kOrange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }
}
