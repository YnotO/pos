import 'package:flutter/material.dart';
import 'features/pos/screens/pos_home_screen.dart'; // Import POSHomeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'POS System',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: POSHomeScreen(), // Set POSHomeScreen as the initial screen
    );
  }
}
