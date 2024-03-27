import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/navigation_functions.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'elements.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

String username = "";
String password = "";
final DatabaseService dbs = new DatabaseService();
final TextEditingController unameTEC = new TextEditingController();
final TextEditingController passTEC = new TextEditingController();

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFEFFD),
      body: Column(
        children: [
          Image.asset(
            "assets/header.png",
            width: 400,
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: Center(
                child: Column(
                  children: [
                    Text("Log In", textAlign: TextAlign.center, style: title1),
                    const SizedBox(
                      height: 60,
                    ),
                    inputField("Username", false, unameTEC),
                    SizedBox(height: 25),
                    inputField("Password", true, passTEC),
                    SizedBox(
                      height: 60,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(180.0, 50.0)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFFFF7AAE))),
                        onPressed: () {
                          setState(() {
                            LogIn(context);
                          });
                        },
                        child: const Text(
                          "Proceed",
                          style: TextStyle(
                              fontSize: 25,
                              fontFamily: "Poppins_bold",
                              color: Color(0xFFFFEFFD),
                              letterSpacing: 3.0),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          LoadPage(context, "register");
                        },
                        child: Text("Create an account?"),
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.zero,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          overlayColor: MaterialStateProperty.all<Color>(
                            Colors.transparent,
                          ),
                          elevation: MaterialStateProperty.all<double>(0),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide.none,
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle title1 = const TextStyle(
    fontFamily: "Poppins", fontSize: 70, color: Color(0xFFFF7AAE));

Container inputField(String hint, bool hidden, TextEditingController tec) {
  return Container(
      padding: EdgeInsets.all(0),
      width: 250,
      height: 50,
      decoration: BoxDecoration(
          color: Color(0xFFFFD9FB),
          border: Border.all(width: 1.8, color: Color(0xFFDE6E9A)),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: TextField(
          controller: tec,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            hintStyle: const TextStyle(
              fontFamily: "Poppins_light",
              fontSize: 20,
              color: Color(0xFFD598CC),
            ),
          ),
          style: const TextStyle(
              fontFamily: "Poppins_bold",
              fontSize: 20,
              color: Color(0xFFFDE6E9A),
              decoration: TextDecoration.none),
          obscureText: hidden,
          cursorColor: Color(0xFFDE6E9A),
        ),
      ));
}

void LogIn(BuildContext context) async {
  username = unameTEC.text;
  password = passTEC.text;

  if (username == "") {
    showSnackBar(context, "Username is empty");
  } else if (password == "") {
    showSnackBar(context, "Password is empty");
  } else {
    try {
      // Call the get_user_snapshot function and await the result
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await dbs.get_user_snapshot(username);

      if (snapshot.docs.isEmpty) {
        showSnackBar(context, "Invalid Username");
        return;
      }

      // Get the first document from the snapshot
      DocumentSnapshot<Map<String, dynamic>> userDocument = snapshot.docs.first;

      // Convert the document snapshot to a User object
      User user = User.fromSnapshot(userDocument);

      if (user.password == password) {
        unameTEC.clear();
        passTEC.clear();
        showSnackBar(context, "Login Successful");
        Provider.of<UserProvider>(context, listen: false).setUser(user);
        LoadPage(context, "home");
      } else {
        showSnackBar(context, "Invalid Password");
      }
    } catch (error) {
      print("Error $error");
    }
  }
}
