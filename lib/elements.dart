import 'package:creamyice/services/navigation_functions.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    duration: Duration(seconds: 1, milliseconds: 30),
    content: Center(
        child: Text(
      msg,
      style: const TextStyle(
          fontSize: 15, fontFamily: "Poppins_bold", letterSpacing: 2.0),
    )),
    backgroundColor: Color(0xFFFF7AAE),
  ));
}

Container TopBar() {
  return Container(
    width: double.infinity,
    height: 110,
    decoration: const BoxDecoration(color: Color(0xFFFF7AAE)),
    child: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 10),
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
            ),
          ),
          const SizedBox(width: 10),
          const Expanded(
            flex: 4,
            child: Center(
              child: Text(
                "Creamy Ice",
                style: TextStyle(
                  fontFamily: "Poppins_bold",
                  fontSize: 35,
                  color: Color(0xFFFFEFFD),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 1,
            child: Container(
              child: Center(
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/menu.png",
                    height: 23,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

AppBar appBar(BuildContext context) {
  return AppBar(
    toolbarHeight: 80,
    centerTitle: true,
    backgroundColor: Color(0xFFFF7AAE),
    leading: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        "assets/logo.png",
        height: 30,
        width: 30,
      ),
    ),
    title: Text(
      "Creamy Ice",
      style: TextStyle(
        fontFamily: "Poppins_bold",
        fontSize: 38,
        color: Color(0xFFFFEFFD),
      ),
    ),
    actions: [
      PopupMenuButton<String>(
        icon: Image.asset(
          "assets/menu.png",
          color: Colors.white,
          height: 25,
        ),
        color: Color(0xFFFF7AAE),
        itemBuilder: (BuildContext context) {
          return {
            'Profile': Icons.account_circle,
            'Home': Icons.shopping_bag,
            'Cart': Icons.shopping_cart,
            'Purchase History': Icons.history,
          }.entries.map((entry) {
            return PopupMenuItem<String>(
              value: entry.key,
              child: Row(
                children: [
                  Icon(
                    entry.value,
                    color: Colors.white, // Set the color of the icon to white
                  ),
                  SizedBox(width: 10),
                  Text(
                    entry.key,
                    style: TextStyle(
                      color: Colors.white, // Set the color of the text to white
                    ),
                  ),
                ],
              ),
            );
          }).toList();
        },
        onSelected: (String choice) {
          switch (choice) {
            case 'Profile':
              LoadPage(context, "profile");
              break;
            case 'Home':
              LoadPage(context, "home");
              break;
            case 'Cart':
              LoadPage(context, "cart");
              break;
            case 'Purchase History':
              break;

            default:
          }
        },
      ),
    ],
  );
}
