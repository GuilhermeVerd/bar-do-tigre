import 'package:flutter/material.dart';
import 'screens/login/login_screen.dart';

void main() {
  runApp(const BarDoTigreApp());
}

class BarDoTigreApp extends StatelessWidget {
  const BarDoTigreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bar do Tigre',
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}
