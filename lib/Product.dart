import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creamyice/elements.dart';
import 'package:creamyice/modals/cartitem.dart';
import 'package:creamyice/modals/product.dart';
import 'package:creamyice/modals/user.dart';
import 'package:creamyice/services/database_service.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  final int pid;
  const ProductPage({Key? key, required this.pid}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

final DatabaseService dbs = new DatabaseService();
late String image = '';
late String name = '';
late double price = 0;
late String description = '';
String username = "";

class _ProductPageState extends State<ProductPage> {
  @override
  void initState() {
    super.initState();

    User? user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      username = user.username;
    }
    SetProductDetails(widget.pid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      backgroundColor: Color(0xFFFFEFFD),
      body: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset("assets/logo.png", height: 180, scale: 2),
              const SizedBox(height: 50),
              Text(name,
                  style: const TextStyle(
                      fontFamily: "Poppins_bold",
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 253, 140, 213))),
              const SizedBox(height: 20),
              Text("\$ " + price.toString(),
                  style: const TextStyle(
                      fontFamily: "Poppins_bold",
                      fontSize: 25,
                      color: Color.fromARGB(177, 67, 12, 112),
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
                child: Text(description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: "Poppins_bold",
                        fontSize: 15,
                        color: Color.fromARGB(137, 67, 12, 112),
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
          const SizedBox(height: 50),
          ElevatedButton(
              onPressed: AddToCart,
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Color(0xFFFF7AAE))),
              child: const Text('Add to Cart',
                  style: TextStyle(
                      fontFamily: "Poppins_bold",
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }

  void AddToCart() async {
    int? old_quantity = await dbs.getQuantity(username, widget.pid);
    int new_quantity;
    if (old_quantity != null) {
      new_quantity = old_quantity + 1;

      double? single_price = await dbs.getprice(widget.pid);
      double total;
      if (single_price != null) {
        total = single_price * new_quantity;
        total = double.parse(total.toStringAsFixed(2));
      } else {
        total = 0;
      }

      Map<String, dynamic> updatedData = {
        'quantity': new_quantity,
        'total': total,
      };

      dbs.updateCartItem(username, widget.pid, updatedData);
      showSnackBar(context, "Cart Updated");
    } else {
      new_quantity = 1;
      double? single_price = await dbs.getprice(widget.pid);
      double total;
      if (single_price != null) {
        total = single_price;
      } else {
        total = 0;
      }

      CartItem cartitem = CartItem(
        username: username,
        pid: widget.pid,
        total: total,
        quantity: new_quantity,
      );

      dbs.addCartitem(cartitem);
      showSnackBar(context, "Cart Updated");
    }
  }

  void SetProductDetails(int p_id) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await dbs.getProductSnapshot(p_id);

      if (!snapshot.docs.isEmpty) {
        DocumentSnapshot<Map<String, dynamic>> productDocument =
            snapshot.docs.first;

        Product _product = Product.fromSnapshot2(productDocument);

        // Update state with product details
        setState(() {
          name = _product.name;
          price = _product.price;
          description = _product.description;
          image = _product.image;
        });
      }
    } catch (error) {
      print("Error $error");
    }
  }
}
