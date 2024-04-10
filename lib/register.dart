import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creamyice/elements.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/navigation_functions.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

String username = "";
String password = "";
String email = "";
String fullname = "";
String address = "";
final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
final TextEditingController fnameTEC = TextEditingController();
final TextEditingController emailTEC = TextEditingController();
final TextEditingController addressTEC = TextEditingController();
final TextEditingController unameTEC = TextEditingController();
final TextEditingController passTEC = TextEditingController();
final DatabaseService dbs = DatabaseService();

class _RegisterPageState extends State<RegisterPage> {
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
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 550,
              child: Center(
                child: Column(
                  children: [
                    Text("Register",
                        textAlign: TextAlign.center, style: title1),
                    const SizedBox(
                      height: 30,
                    ),
                    inputField("Full Name", false, fnameTEC),
                    SizedBox(height: 15),
                    inputField("Email", false, emailTEC),
                    SizedBox(height: 15),
                    inputField("Address", false, addressTEC),
                    SizedBox(height: 15),
                    inputField("Username", false, unameTEC),
                    SizedBox(height: 15),
                    inputField("Password", true, passTEC),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all(Size(180.0, 50.0)),
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Color(0xFFFF7AAE))),
                        onPressed: () {
                          setState(() {
                            Register(context);
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
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          LoadPage(context, "login");
                        },
                        child: Text("Already have an account?"),
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
      width: 280,
      height: 40,
      decoration: BoxDecoration(
          color: Color(0xFFFFD9FB),
          border: Border.all(width: 1.8, color: Color(0xFFDE6E9A)),
          borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: TextField(
          controller: tec,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            hintStyle: const TextStyle(
              fontFamily: "Poppins_light",
              fontSize: 18,
              color: Color(0xFFD598CC),
            ),
          ),
          style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: "Poppins_bold",
              fontSize: 15,
              color: Color(0xFFFDE6E9A),
              decoration: TextDecoration.none),
          obscureText: hidden,
          cursorColor: Color(0xFFDE6E9A),
        ),
      ));
}

void Register(BuildContext context) async {
  fullname = fnameTEC.text;
  email = emailTEC.text;
  address = addressTEC.text;
  username = unameTEC.text;
  password = passTEC.text;

  bool existingUname;

  QuerySnapshot<Map<String, dynamic>> snapshot =
      await dbs.get_user_snapshot(username);

  if (snapshot.docs.isEmpty) {
    existingUname = false;
  } else {
    existingUname = true;
  }

  if (fullname == "") {
    showSnackBar(context, "Full Name is empty");
    ;
  } else if (email == "") {
    showSnackBar(context, "Email is empty");
    ;
  } else if (address == "") {
    showSnackBar(context, "Address is empty");
    ;
  } else if (username == "") {
    showSnackBar(context, "Username is empty");
  } else if (password == "") {
    showSnackBar(context, "Password is empty");
  } else if (!emailRegex.hasMatch(email)) {
    showSnackBar(context, "Invalid Email");
  } else if (username.length < 5) {
    showSnackBar(context, "Username must atleast be 5 letters");
  } else if (password.length < 5) {
    showSnackBar(context, "Password must atleast be 5 letters");
  } else if (existingUname) {
    showSnackBar(context, "Username already exists");
  } else {
    fnameTEC.clear();
    emailTEC.clear();
    addressTEC.clear();
    unameTEC.clear();
    passTEC.clear();
    showSnackBar(context, "Registration Successful");
    User user = User(
        fullname: fullname,
        email: email,
        address: address,
        username: username,
        password: password);
    dbs.addUser(user);
    LoadPage(context, "login");
  }
}
