import 'package:bukuta_poultry/state/cart.dart';
import 'package:bukuta_poultry/utils/index.dart';
import 'package:bulksmszw/bulksmszw.dart';
import 'package:flutter/material.dart';
import 'package:paynow/paynow.dart';
import 'package:provider/provider.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    kDimension dimension = new kDimension(context);
    return Consumer<CartController>(
      builder: (context, cart, child) {
        List cartItems = cart.cartItems;
        return Scaffold(
          appBar: AppBar(
            elevation: 1.0,
            centerTitle: true,
            title: Text(
              "Cart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: Container(
            height: dimension.height,
            width: dimension.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cartItems
                      .map(
                        (cartItem) => ListTile(
                          title: Text(cartItem.name),
                          subtitle: Text(
                              "Quantity: ${cartItem.count}; Cost: \$${double.parse(cartItem.price) * cartItem.count}"),
                          trailing: GestureDetector(
                            onTap: () {
                              cart.removeFromCart(cartItem);
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Total Cost: \$${cart.cost()}",
                    style: TextStyle(
                      color: kDark,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: kOrange,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: dimension.width,
                  child: MaterialButton(
                    onPressed: () async {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Attempting to send order"),
                        ),
                      );
                      BulkSmsZw _api = new BulkSmsZw(
                        bulksmsWebKey: '96b06334dde4d0673be6a1bf7972d35f',
                        bulksmsWebName: 'iamngoni',
                      );

                      ApiResponse response = await _api.send(
                          message:
                              "Hello Bukuta Poultry. I need the following: ${cart.cartItems.toString()}",
                          recipients: ['0782617420']);
                      print(response);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(response.message),
                        ),
                      );
                    },
                    child: Text(
                      "Make Order Via Sms",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: kOrange,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  width: dimension.width,
                  child: MaterialButton(
                    onPressed: () async {
                      TextEditingController _number =
                          new TextEditingController();
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: Text("Ecocash Payment"),
                          content: TextField(
                            controller: _number,
                            decoration: InputDecoration(
                              labelText: "Ecocash Number",
                            ),
                            keyboardType: TextInputType.number,
                          ),
                          actions: <Widget>[
                            FlatButton(
                              onPressed: () async {
                                Scaffold.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Attempting payment"),
                                  ),
                                );
                                Paynow paynow = new Paynow(
                                  integrationId: '8379',
                                  integrationKey:
                                      'a671ff85-94dc-4613-93f2-9d3de0f5d5ff',
                                );
                                Payment payment = paynow.createPayment(
                                  "Bukuta Poultry",
                                  "ngmangudya@gmail.com",
                                );
                                cartItems.forEach((element) {
                                  payment.add(
                                    element.name,
                                    double.parse(element.price) *
                                        element.count *
                                        100,
                                  );
                                });

                                InitResponse response = await paynow.sendMobile(
                                  payment,
                                  _number.text,
                                );
                                if (response.success) {
                                  print(response.instructions);
                                  await Future.delayed(Duration(seconds: 3));
                                  StatusResponse statusResponse = await paynow
                                      .checkTransactionStatus(response.pollUrl);
                                  if (statusResponse.paid) {
                                    Navigator.of(ctx).pop();
                                  } else {
                                    Navigator.of(ctx).pop();
                                  }
                                } else {
                                  Navigator.of(ctx).pop();
                                }
                              },
                              child: Text("Proceed"),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Text(
                      "Make Payment Via Ecocash",
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
        );
      },
    );
  }
}
