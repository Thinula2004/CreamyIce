import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creamyice/elements.dart';
import 'package:creamyice/modals/cartitem.dart';
import 'package:creamyice/modals/purchase.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/navigation_functions.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

bool menuActive = false;
DatabaseService dbs = new DatabaseService();
double full_total = 0;
String uname = "";
bool isEmpty = false;
int purchasesCount = 0;

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    updatePurchasesCount();
    User? user = Provider.of<UserProvider>(context).user;
    if (user != null) {
      uname = user.username;
    }
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Color(0xFFFFEFFD),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 60,
            ),
            Text("Cart", textAlign: TextAlign.center, style: title1),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: EdgeInsets.all(20),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFEFFD),
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x326F58A9), // Shadow color
                          spreadRadius: 6, // Spread radius
                          blurRadius: 7, // Blur radius
                          offset: Offset(0, 0), // Offset in x and y directions
                        )
                      ]),
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 5,
                                  child: Center(
                                    child: Text(
                                      "Product Name",
                                      style: label01,
                                    ),
                                  )),
                              divider02,
                              Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: Text(
                                      "Qty",
                                      style: label01,
                                    ),
                                  )),
                              divider02,
                              Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      "Price (\$)",
                                      style: label01,
                                    ),
                                  )),
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.transparent,
                                      )))
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          divider01,
                          StreamBuilder<List<CartItem>>(
                            stream: dbs.getCartitems(uname),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                isEmpty = true;
                                return Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '...Cart is empty...',
                                      style: label04,
                                    )
                                  ],
                                );
                              } else {
                                isEmpty = false;
                                final cartitems = snapshot.data!;
                                full_total = calculateTotal(cartitems);
                                return Column(children: [
                                  ...cartitems.map((cartitem) {
                                    return itemRow(cartitem);
                                  }).toList(),
                                  bottomRow(full_total)
                                ]);
                              }
                            },
                          ),
                        ],
                      )),
                )),
            const SizedBox(
              height: 20,
            ),
            button01(context),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

  Widget itemRow(CartItem cartitem) {
    return FutureBuilder<String?>(
        future: dbs.getProductName(cartitem.pid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(color: Color(0xFFFF7AAE));
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              String productName = snapshot.data!;

              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Center(
                          child: Text(productName,
                              style: label03, textAlign: TextAlign.center),
                        ),
                      ),
                      divider02,
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Text(
                            cartitem.quantity.toString(),
                            style: label03,
                          ),
                        ),
                      ),
                      divider02,
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Text(
                            "\$" + cartitem.total.toString(),
                            style: label03,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          // Wrap IconButton with GestureDetector
                          onTap: () {
                            // Add your onPressed logic here
                            print('Delete button pressed');
                          },
                          child: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              DeleteCartItem(context, uname, cartitem.pid);
                            }, // Set to null if you want onPressed to do nothing
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  divider01,
                ],
              );
            } else {
              return Container();
            }
          }
        });
  }

  double calculateTotal(List<CartItem> cartitems) {
    double total = 0;
    for (final cartitem in cartitems) {
      total += cartitem.total;
    }
    return total;
  }

  Column bottomRow(double total) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Text("Total", style: label04, textAlign: TextAlign.right),
            ),
            divider02,
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  "\$${total.toStringAsFixed(2)}",
                  style: label04,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                // Wrap IconButton with GestureDetector
                onTap: () {
                  // Add your onPressed logic here
                  print('Delete button pressed');
                },
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.transparent,
                  ),
                  onPressed:
                      () {}, // Set to null if you want onPressed to do nothing
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        divider01,
      ],
    );
  }
}

void DeleteCartItem(BuildContext context, String _uname, int _pid) {
  dbs.deleteCartItem(_uname, _pid);
  LoadPage(context, 'cart');
  showSnackBar(context, "Item Removed from cart");
}

ElevatedButton button01(BuildContext context) {
  return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(0, 40.0)),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Color(0xFFFF7AAE))),
      onPressed: () {
        MakePurchase(context);
      },
      child: const Text(
        "Purchase",
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins_bold",
            color: Color(0xFFFFEFFD),
            letterSpacing: 2.0),
      ));
}

void MakePurchase(BuildContext context) {
  if (isEmpty) {
    showSnackBar(context, "Cart is empty");
  } else {
    Purchase purchase = Purchase(
        username: uname,
        id: purchasesCount + 1,
        total: double.parse(full_total.toStringAsFixed(2)),
        time: Timestamp.now());
    dbs.addPurchase(uname, purchase);
    showSnackBar(context, "Purchase made successfully");
    LoadPage(context, "cart");
  }
}

void updatePurchasesCount() async {
  purchasesCount = await dbs.GetPurchasesAmount();
  print("Purchases Amount = " + purchasesCount.toString());
}

TextStyle label01 = const TextStyle(
  color: Color(0xFF915086),
  fontSize: 12,
  fontFamily: "Poppins_bold",
);
TextStyle label03 = const TextStyle(
  color: Color(0xFFFF7AAE),
  fontSize: 12,
  fontFamily: "Poppins_bold",
);
TextStyle label04 = const TextStyle(
  color: Color(0xFFFF7AAE),
  fontSize: 15,
  fontFamily: "Poppins_bold",
);

Divider divider01 = const Divider(
  color: Color(0xFF6F58A9),
  thickness: 1.5,
  height: 10,
);

Container divider02 = Container(
    height: 50, width: 2, margin: EdgeInsets.symmetric(horizontal: 15));
TextStyle label02 = const TextStyle(
    fontFamily: "Poppins", fontSize: 15, color: Color(0xFFFF7AAE));

TextStyle title1 = const TextStyle(
    fontFamily: "Poppins_bold", fontSize: 30, color: Color(0xFFFF7AAE));
