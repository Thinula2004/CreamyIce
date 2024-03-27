import 'dart:ui';
import 'package:creamyice/elements.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

bool menuActive = false;

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Color(0xFFFFEFFD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
          ),
          Text("Cart", textAlign: TextAlign.center, style: title1),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 20,
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
              ))
        ],
      ),
    );
  }
}

Divider divider01 = Divider(
  color: Color(0xFF6F58A9),
  thickness: 1.5,
  height: 10,
);

TextStyle label02 = const TextStyle(
    fontFamily: "Poppins", fontSize: 15, color: Color(0xFFFF7AAE));

TextStyle title1 = const TextStyle(
    fontFamily: "Poppins_bold", fontSize: 30, color: Color(0xFFFF7AAE));

Container app_bar(BuildContext context) {
  return Container(
    width: double.infinity,
    height: 110,
    decoration: BoxDecoration(color: Color(0xFFFF7AAE)),
    child: SafeArea(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Container(
                    child: Image.asset(
                      "assets/logo.png",
                      height: 60,
                    ),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            const Expanded(
                flex: 4,
                child: Center(
                  child: Text(
                    "Creamy Ice",
                    style: TextStyle(
                        fontFamily: "Poppins_bold",
                        fontSize: 35,
                        color: Color(0xFFFFEFFD)),
                  ),
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: Center(
                      child: IconButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/register', (route) => false);
                    },
                    icon: Image.asset(
                      "assets/menu.png",
                      height: 23,
                    ),
                  )),
                ))
          ]),
    ),
  );
}

void ToggleMenu() {
  menuActive != menuActive;
}
