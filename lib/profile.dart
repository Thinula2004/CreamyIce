import 'dart:ui';
import 'package:creamyice/elements.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/navigation_functions.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

bool menuActive = false;
String fname = "";
String email = "";
String address = "";
String uname = "";

final DatabaseService dbs = new DatabaseService();

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    if (user != null) {
      fname = user.fullname;
      email = user.email;
      address = user.address;
      uname = user.username;
    }

    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Color(0xFFFFEFFD),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
          ),
          Text("Customer Profile", textAlign: TextAlign.center, style: title1),
          SizedBox(
            height: 40,
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
                  ],
                ),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 35),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              Text(
                                "Full Name : ",
                                style: label01,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Text(
                                  fname,
                                  style: label02,
                                  overflow: TextOverflow
                                      .ellipsis, // or TextOverflow.ellipsis
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: Color(0xFF6F58A9),
                          thickness: 1.5,
                          height: 10,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Email : ",
                                  style: label01,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    email,
                                    style: label02,
                                    overflow: TextOverflow
                                        .ellipsis, // or TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: Color(0xFF6F58A9),
                          thickness: 1.5,
                          height: 10,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Address : ",
                                  style: label01,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    address,
                                    style: label02,
                                    overflow: TextOverflow
                                        .ellipsis, // or TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 15,
                        ),
                        Divider(
                          color: Color(0xFF6F58A9),
                          thickness: 1.5,
                          height: 10,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Username : ",
                                  style: label01,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    uname,
                                    style: label02,
                                    overflow: TextOverflow
                                        .ellipsis, // or TextOverflow.ellipsis
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ))),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(0, 40.0)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFFFF7AAE))),
                  onPressed: () {
                    setState(() {
                      LogOut(context);
                    });
                  },
                  child: const Text(
                    "Log Out",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Poppins_bold",
                        color: Color(0xFFFFEFFD),
                        letterSpacing: 2.0),
                  )),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(Size(0, 40.0)),
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Color(0xFFFF7AAE))),
                  onPressed: () {
                    setState(() {
                      DelAcc(context);
                    });
                  },
                  child: const Text(
                    "Delete Account",
                    style: TextStyle(
                        fontSize: 17,
                        fontFamily: "Poppins_bold",
                        color: Color(0xFFFFEFFD),
                        letterSpacing: 2.0),
                  ))
            ],
          )
        ],
      ),
    );
  }
}

void LogOut(BuildContext context) {
  print("Logged out");
  Provider.of<UserProvider>(context, listen: false).setUser(null);
  showSnackBar(context, "Log-out Successful");
  LoadPage(context, "login");
}

void DelAcc(BuildContext context) {
  print("Account Deleted");
  Provider.of<UserProvider>(context, listen: false).setUser(null);
  dbs.deleteUser(uname);
  showSnackBar(context, "Account Deletion Successful");
  LoadPage(context, "register");
}

TextStyle label01 = const TextStyle(
    fontFamily: "Poppins",
    fontSize: 15,
    color: Color.fromARGB(255, 96, 77, 143));

TextStyle label02 = const TextStyle(
    fontFamily: "Poppins", fontSize: 15, color: Color(0xFFFF7AAE));

TextStyle title1 = const TextStyle(
    fontFamily: "Poppins_bold", fontSize: 30, color: Color(0xFFFF7AAE));

void ToggleMenu() {
  menuActive != menuActive;
}
