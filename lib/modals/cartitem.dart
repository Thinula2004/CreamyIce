import 'package:cloud_firestore/cloud_firestore.dart';

class CartItem {
  String username;
  int pid;
  int quantity;
  double total;

  CartItem(
      {required this.username,
      required this.pid,
      required this.total,
      required this.quantity});

  CartItem.fromJson(Map<String, Object?> json)
      : this(
            username: json['username']! as String,
            pid: json['pid']! as int,
            total: json['total']! as double,
            quantity: json['quantity']! as int);

  CartItem.fromSnapshot(QueryDocumentSnapshot snapshot)
      : username = snapshot.get('username'),
        pid = snapshot.get('pid'),
        total = snapshot.get('total').toDouble(),
        quantity = snapshot.get('quantity');

  CartItem.fromSnapshot2(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : username = snapshot.get('username'),
        pid = snapshot.get('pid'),
        total = snapshot.get('total').toDouble(),
        quantity = snapshot.get('quantity');

  Map<String, Object> toJson() {
    return {
      "username": username,
      "pid": pid,
      "total": total,
      "quantity": quantity
    };
  }
}
