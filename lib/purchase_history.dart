import 'package:creamyice/elements.dart';
import 'package:flutter/material.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({super.key});

  @override
  State<PurchasesPage> createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage> {
  @override
  Widget build(BuildContext context) {
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
                              Expanded(
                                  flex: 1,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.transparent,
                                      )))
                            ],
                          ),
                          divider01,
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
}

ElevatedButton button01(BuildContext context) {
  return ElevatedButton(
      style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(Size(0, 40.0)),
          backgroundColor:
              MaterialStateColor.resolveWith((states) => Color(0xFFFF7AAE))),
      onPressed: () {},
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
