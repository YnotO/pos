import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'features/pos/screens/pos_home_screen.dart'; // Import POSHomeScreen

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://ntajimbiohwfbnngtzco.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im50YWppbWJpb2h3ZmJubmd0emNvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk3MjAyOTksImV4cCI6MjA1NTI5NjI5OX0.NucWIUDCQeV1U79y0fn-tzh8idbf4sm0_Q9ZPFG3-BY'); // Initialize Firebase

  runApp(MyApp());
}

// Get a reference your Supabase client
final supabase = Supabase.instance.client;

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
