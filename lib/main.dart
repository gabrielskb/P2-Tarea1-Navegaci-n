import 'package:flutter/material.dart';
import 'welcome/bienvenida_screen.dart';

void main() {
  runApp(const MiPortfolioApp());
}

class MiPortfolioApp extends StatelessWidget {
  const MiPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BienvenidaScreen(),
    );
  }
}
