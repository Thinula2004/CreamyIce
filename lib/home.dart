import 'dart:math';

import 'package:creamyice/elements.dart';
import 'package:creamyice/modals/product.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/navigation_functions.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final DatabaseService dbs = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Color(0xFFFFEFFD),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    StreamBuilder<List<Product>>(
                      stream: dbs.getProducts(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Center(child: Text('No products available'));
                        }
                        final products = snapshot.data!;
                        final rowsCount = (products.length / 3).ceil();
                        return Column(
                          children: List.generate(rowsCount, (rowIndex) {
                            final start = rowIndex * 3;
                            final end = (rowIndex + 1) * 3;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: products
                                  .sublist(start, min(end, products.length))
                                  .map((product) {
                                return p_card(
                                    context: context,
                                    title: product.name,
                                    price: product.price.toString(),
                                    image: product.image,
                                    id: product.id);
                              }).toList(),
                            );
                          }),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding p_card(
      {required BuildContext context,
      required String title,
      required String price,
      required String image,
      required int id}) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: GestureDetector(
          onTap: () {
            LoadPage(context, "product", id);
          },
          child: Container(
            width: 115,
            height: 150,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 8,
                  offset: Offset(0, 0),
                )
              ],
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
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
                    width: 120,
                    height: 55,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFFF7AAE),
                            fontSize: 9,
                            fontFamily: "Poppins_bold",
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Price : \$$price",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF915086),
                            fontSize: 9,
                            fontFamily: "Poppins_bold",
                          ),
                        ),
                        SizedBox(height: 5),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
