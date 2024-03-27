import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String fullname;
  String email;
  String address;
  String username;
  String password;

  User(
      {required this.fullname,
      required this.email,
      required this.address,
      required this.username,
      required this.password});

  User.fromJson(Map<String, Object?> json)
      : this(
            fullname: json['fullname']! as String,
            email: json['email']! as String,
            address: json['address']! as String,
            username: json['username']! as String,
            password: json['password']! as String);

  User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : fullname = snapshot.get('fullname'),
        email = snapshot.get('email'),
        address = snapshot.get('address'),
        username = snapshot.get('username'),
        password = snapshot.get('password');

  Map<String, Object> toJson() {
    return {
      "fullname": fullname,
      "email": email,
      "address": address,
      "username": username,
      "password": password
    };
  }
}
