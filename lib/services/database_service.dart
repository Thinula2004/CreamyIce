import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creamyice/modals/cartitem.dart';
import 'package:creamyice/modals/product.dart';
import 'package:creamyice/modals/purchase.dart';
import 'package:creamyice/modals/user.dart';

const String USER_COLLECTION_REF = "users";
const String PRODUCT_COLLECTION_REF = "products";
const String CARTITEM_COLLECTION_REF = "cartitems";
const String PURCHASES_COLLECTION_REF = 'purchases';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _usersRef;
  late final CollectionReference _productsRef;
  late final CollectionReference _cartitemsRef;
  late final CollectionReference _purchasesRef;

  DatabaseService() {
    _usersRef = _firestore.collection(USER_COLLECTION_REF).withConverter<User>(
        fromFirestore: (snapshots, _) => User.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (user, _) => user.toJson());

    _productsRef = _firestore
        .collection(PRODUCT_COLLECTION_REF)
        .withConverter<Product>(
            fromFirestore: (snapshots, _) =>
                Product.fromJson(snapshots.data()!),
            toFirestore: (product, _) => product.toJson());

    _cartitemsRef = _firestore
        .collection(CARTITEM_COLLECTION_REF)
        .withConverter<CartItem>(
            fromFirestore: (snapshots, _) =>
                CartItem.fromJson(snapshots.data()!),
            toFirestore: (cartitem, _) => cartitem.toJson());

    _purchasesRef = _firestore.collection("purchases").withConverter<Purchase>(
        fromFirestore: (snapshots, _) => Purchase.fromJson(snapshots.data()!),
        toFirestore: (purchase, _) => purchase.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> get_user_snapshot(
      String uname) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('username', isEqualTo: uname)
        .get();

    return snapshot;
  }

  Future<int?> getQuantity(String _uname, int _pid) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('cartitems')
        .where('username', isEqualTo: _uname)
        .where('pid', isEqualTo: _pid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['quantity'] as int;
    } else {
      return null;
    }
  }

  Future<double?> getprice(int _pid) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('products')
        .where('id', isEqualTo: _pid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['price'] as double;
    } else {
      return null;
    }
  }

  Future<String?> getProductName(int _pid) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('products')
        .where('id', isEqualTo: _pid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['name'] as String;
    } else {
      return null;
    }
  }

  void addUser(User user) async {
    _usersRef.add(user);
  }

  void addPurchase(String username, Purchase purchase) async {
    _purchasesRef.add(purchase);
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(CARTITEM_COLLECTION_REF)
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isNotEmpty) {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      snapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await batch.commit();
    }
  }

  void deleteUser(String username) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.first.reference.delete();

      QuerySnapshot<Map<String, dynamic>> snapshot2 = await FirebaseFirestore
          .instance
          .collection("cartitems")
          .where('username', isEqualTo: username)
          .get();

      if (snapshot2.docs.isNotEmpty) {
        WriteBatch batch = FirebaseFirestore.instance.batch();
        snapshot2.docs.forEach((doc) {
          batch.delete(doc.reference);
        });

        await batch.commit();
      }
    }
  }

  Stream<List<Product>> getProducts() {
    return _productsRef.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((doc) => Product.fromSnapshot(doc)).toList());
  }

  Stream<List<CartItem>> getCartitems(String username) {
    return _cartitemsRef.where('username', isEqualTo: username).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => CartItem.fromSnapshot(doc))
            .toList());
  }

  Stream<List<Purchase>> getPurchases(String username) {
    return _purchasesRef.where('username', isEqualTo: username).snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => Purchase.fromSnapshot(doc))
            .toList());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getProductSnapshot(int id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('products')
        .where('id', isEqualTo: id)
        .get();

    return snapshot;
  }

  void addCartitem(CartItem cartitem) async {
    _cartitemsRef.add(cartitem);
  }

  void updateCartItem(
      String username, int pid, Map<String, dynamic> updatedData) async {
    print(username + pid.toString());
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('cartitems')
          .where('username', isEqualTo: username)
          .where('pid', isEqualTo: pid)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.update(updatedData);
      } else {
        print("No data found");
      }
    } catch (error) {
      print("Error updating cart item: $error");
    }
  }

  void deleteCartItem(String username, int pid) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('cartitems')
        .where('username', isEqualTo: username)
        .where('pid', isEqualTo: pid)
        .get();

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.first.reference.delete();
    }
  }

  void ResetPurchases(String username) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection(PURCHASES_COLLECTION_REF)
        .where('username', isEqualTo: username)
        .get();

    if (snapshot.docs.isNotEmpty) {
      WriteBatch batch = FirebaseFirestore.instance.batch();
      snapshot.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await batch.commit();
    }
  }

  Future<int> GetPurchasesAmount() async {
    int amount = 0;
    QuerySnapshot snapshots = await _purchasesRef.get();
    amount = snapshots.docs.length;
    return amount;
  }
}
