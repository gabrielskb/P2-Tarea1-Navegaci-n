import 'package:flutter/material.dart';

class CabeceraPortfolio extends StatelessWidget {
  const CabeceraPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Color.fromARGB(255, 231, 240, 246),
      padding: const EdgeInsets.all(12),
      child: const Text(
        'Este es mi portfolio',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}