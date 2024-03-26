import 'dart:ui';
import 'package:flutter/material.dart';
import 'login.dart';

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
                    inputField("Full Name", false, (value) {
                      setState(() {
                        fullname = value;
                      });
                    }),
                    SizedBox(height: 15),
                    inputField("Email", false, (value) {
                      setState(() {
                        email = value;
                      });
                    }),
                    SizedBox(height: 15),
                    inputField("Address", false, (value) {
                      setState(() {
                        address = value;
                      });
                    }),
                    SizedBox(height: 15),
                    inputField("Username", false, (value) {
                      setState(() {
                        username = value;
                      });
                    }),
                    SizedBox(height: 15),
                    inputField("Password", true, (value) {
                      setState(() {
                        password = value;
                      });
                    }),
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
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/login', (route) => false);
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

Container inputField(String hint, bool hidden, Function(String) onChanged) {
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
          onChanged: onChanged,
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

void LogIn(BuildContext context) {
  if (fullname == "") {
    snackBar(context, "Full Name is empty");
    ;
  } else if (email == "") {
    snackBar(context, "Email is empty");
    ;
  } else if (address == "") {
    snackBar(context, "Address is empty");
    ;
  } else if (username == "") {
    snackBar(context, "Username is empty");
  } else if (password == "") {
    snackBar(context, "Password is empty");
  } else if (!emailRegex.hasMatch(email)) {
    snackBar(context, "Invalid Email");
  } else if (username.length < 5) {
    snackBar(context, "Username must atleast be 5 letters");
  } else if (password.length < 5) {
    snackBar(context, "Password must atleast be 5 letters");
  } else {
    snackBar(context, "Registration Successful");
    print("Logged in with username : " +
        username +
        " and password : " +
        password);
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    BuildContext context, String txt) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      content: Center(
        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Poppins_bold",
            letterSpacing: 2.0,
          ),
        ),
      ),
      backgroundColor: Color(0xFFFF7AAE),
    ),
  );
}
