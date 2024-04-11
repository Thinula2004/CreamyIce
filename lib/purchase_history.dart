import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creamyice/elements.dart';
import 'package:creamyice/login.dart';
import 'package:creamyice/modals/purchase.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/navigation_functions.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

String username = "";
bool isEmpty = true;

class _PurchasesPageState extends State<PurchasesPage> {
  late DatabaseService dbs;
  late Stream<List<Purchase>> pStream;

  @override
  void initState() {
    super.initState();

    dbs = DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    if (user != null) {
      username = user.username;
    }
    pStream = dbs.getPurchases(username);

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
            Text("Purchase History",
                textAlign: TextAlign.center, style: title1),
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
                                  flex: 4,
                                  child: Center(
                                    child: Text(
                                      "Order No.",
                                      style: label01,
                                    ),
                                  )),
                              divider02,
                              Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      "Date",
                                      style: label01,
                                    ),
                                  )),
                              divider02,
                              Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      "Total (\$)",
                                      style: label01,
                                    ),
                                  )),
                            ],
                          ),
                          divider01,
                          StreamBuilder<List<Purchase>>(
                            stream: DatabaseService().getPurchases(username),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                isEmpty = true;
                                return Center(
                                  child: Column(
                                    children: [
                                      SizedBox(height: 20),
                                      Text(
                                        '... None ...',
                                        style: label04,
                                      )
                                    ],
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Center(
                                  child: Text('Error: ${snapshot.error}'),
                                );
                              } else {
                                isEmpty = false;
                                return ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Purchase purchase = snapshot.data![index];

                                    return purchaseRow(
                                        id: purchase.id,
                                        time: purchase.time,
                                        total: purchase.total);
                                  },
                                );
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

  Widget purchaseRow(
      {required int id, required Timestamp time, required double total}) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 4,
              child: Center(
                child:
                    Text("#$id", style: label03, textAlign: TextAlign.center),
              ),
            ),
            divider02,
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  DateFormat.yMd().add_jm().format(time.toDate()).toString(),
                  style: label03,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            divider02,
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  "\$$total",
                  style: label03,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
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

ElevatedButton button01(BuildContext context) {
  return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(0, 40.0)),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Color(0xFFFF7AAE))),
      onPressed: () {
        if (isEmpty) {
          showSnackBar(context, "Already Resetted");
        } else {
          dbs.ResetPurchases(username);
          LoadPage(context, "purchases");
          showSnackBar(context, "Reset Successful");
        }
      },
      child: const Text(
        "Reset",
        style: TextStyle(
            fontSize: 20,
            fontFamily: "Poppins_bold",
            color: Color(0xFFFFEFFD),
            letterSpacing: 2.0),
      ));
}

Divider divider01 = const Divider(
  color: Color(0xFF6F58A9),
  thickness: 1.5,
  height: 10,
);

TextStyle label01 = const TextStyle(
  color: Color(0xFF915086),
  fontSize: 12,
  fontFamily: "Poppins_bold",
);
Container divider02 = Container(
    height: 50, width: 2, margin: EdgeInsets.symmetric(horizontal: 15));

TextStyle title1 = const TextStyle(
    fontFamily: "Poppins_bold", fontSize: 30, color: Color(0xFFFF7AAE));

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
