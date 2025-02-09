import 'package:flutter/material.dart';
import 'package:needed_app/screens/worker_signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Needed App',
      home: WorkerSignup(),
    );
  }
}
