import 'dart:ui';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

String username = "";
String password = "";

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
                    inputField("Username", false, (value) {
                      setState(() {
                        username = value;
                      });
                    }),
                    SizedBox(height: 25),
                    inputField("Password", true, (value) {
                      setState(() {
                        password = value;
                      });
                    }),
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
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/register', (route) => false);
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

Container inputField(String hint, bool hidden, Function(String) onChanged) {
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
          onChanged: onChanged,
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

void LogIn(BuildContext context) {
  if (username == "") {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child: Text(
        "Username is empty",
        style: TextStyle(
            fontSize: 15, fontFamily: "Poppins_bold", letterSpacing: 2.0),
      )),
      backgroundColor: Color(0xFFFF7AAE),
    ));
  } else if (password == "") {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child: Text(
        "Password is empty",
        style: TextStyle(
            fontSize: 15, fontFamily: "Poppins_bold", letterSpacing: 2.0),
      )),
      backgroundColor: Color(0xFFFF7AAE),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child: Text(
        "Log In Successful !",
        style: TextStyle(
            fontSize: 15, fontFamily: "Poppins_bold", letterSpacing: 2.0),
      )),
      backgroundColor: Color(0xFFFF7AAE),
    ));
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}
