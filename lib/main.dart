import 'package:creamyice/purchase_history.dart';
import 'package:creamyice/services/user_provider.dart';
import 'package:creamyice/test.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';
import 'profile.dart';
import 'cart.dart';

import 'firebase_options.dart';

Future<void> main() async {
  // Wait for Firebase to initialize before running the app
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/cart': (context) => const CartPage(),
        '/purchases': (context) => PurchasesPage()
      },
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
