import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  int id;
  String name;
  String description;
  double price;
  String image;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.image});

  Product.fromJson(Map<String, Object?> json)
      : this(
            id: json['id']! as int,
            name: json['name']! as String,
            description: json['description']! as String,
            price: json['price']! as double,
            image: json['image']! as String);

  Product.fromSnapshot(QueryDocumentSnapshot snapshot)
      : id = snapshot.get('id'),
        name = snapshot.get('name'),
        description = snapshot.get('description'),
        price = snapshot.get('price').toDouble(),
        image = snapshot.get('image');

  Product.fromSnapshot2(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.get('id'),
        name = snapshot.get('name'),
        description = snapshot.get('description'),
        price = snapshot.get('price').toDouble(),
        image = snapshot.get('image');

  Map<String, Object> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "price": price,
      "image": image
    };
  }
}
