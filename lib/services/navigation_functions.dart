import 'package:creamyice/cart.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/product.dart';
import 'package:creamyice/profile.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void LoadPage(BuildContext context, String page, [int? pid]) {
  User? user = Provider.of<UserProvider>(context, listen: false).user;
  if (page == "login") {
    if (user != null) {
      page = "profile";
    }
  }
  if (page == "register") {
    if (user != null) {
      page = "profile";
    }
  }
  if (page == "profile" || page == "home") {
    if (user == null) {
      page = "login";
    }
  }

  if (pid == null) {
    if (page == "profile") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfilePage(),
        ),
      );
    } else if (page == "cart") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CartPage(),
        ),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/' + page, (route) => false);
    }
  } else {
    if (page == "product") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(pid: pid),
        ),
      );
    }
  }
}
