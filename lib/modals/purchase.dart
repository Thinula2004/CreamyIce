import 'package:cloud_firestore/cloud_firestore.dart';

class Purchase {
  int id;
  Timestamp time;
  String username;
  double total;

  Purchase(
      {required this.username,
      required this.id,
      required this.total,
      required this.time});

  Purchase.fromJson(Map<String, Object?> json)
      : this(
            username: json['username']! as String,
            id: json['id']! as int,
            total: json['total']! as double,
            time: json['time']! as Timestamp);

  Purchase.fromSnapshot(QueryDocumentSnapshot snapshot)
      : username = snapshot.get('username'),
        id = snapshot.get('id'),
        total = snapshot.get('total').toDouble(),
        time = snapshot.get('time');

  Purchase.fromSnapshot2(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : username = snapshot.get('username'),
        id = snapshot.get('id'),
        total = snapshot.get('total').toDouble(),
        time = snapshot.get('time');

  Map<String, Object> toJson() {
    return {"username": username, "id": id, "total": total, "time": time};
  }
}
