import 'dart:ui';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

bool menuActive = false;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFFD),
      body: Column(
        children: [
          Container(
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
                            onPressed: ToggleMenu,
                            icon: Image.asset(
                              "assets/menu.png",
                              height: 23,
                            ),
                          )),
                        ))
                  ]),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 1),
            child: Expanded(
              child: Wrap(
                children: [
                  p_card(),
                  p_card(),
                  p_card(),
                  p_card(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

void ToggleMenu() {
  menuActive != menuActive;
}

Padding p_card() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 7),
    child: Container(
      width: 115,
      height: 150,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25), // Shadow color
              spreadRadius: 3, // Spread radius
              blurRadius: 5, // Blur radius
              offset: Offset(0, 0), // Offset in x and y directions
            )
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 110,
                height: 85,
                child: Image.asset(
                  "assets/ice1.png",
                  width: 90,
                ),
              ),
              Container(
                width: 100,
                height: 55,
                child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Chocolate Ice Cream",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFFF7AAE),
                            fontSize: 9,
                            fontFamily: "Poppins_bold"),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Price : \$2.50",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFF915086),
                            fontSize: 9,
                            fontFamily: "Poppins_bold"),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ]),
              )
            ]),
      ),
    ),
  );
}
