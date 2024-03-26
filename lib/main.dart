import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'login.dart';
import 'register.dart';
import 'home.dart';
import 'profile.dart';
import 'cart.dart';

void main() {
  // Wait for Firebase to initialize before running the app

  runApp(MaterialApp(
    routes: {
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/home': (context) => const HomePage(),
      '/profile': (context) => const ProfilePage(),
      '/cart': (context) => const CartPage()
    },
    debugShowCheckedModeBanner: false,
    home: const CartPage(),
  ));
}
