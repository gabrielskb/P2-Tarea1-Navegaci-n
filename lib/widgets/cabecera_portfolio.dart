
import 'package:flutter/material.dart';
import '../menu/menu_lateral.dart';

class CabeceraPortfolio extends StatelessWidget {
  const CabeceraPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 161, 209, 241),
      padding: const EdgeInsets.all(12),
      child: SizedBox(
        height: 48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // TÍTULO ORIGINAL
            const Text(
              'Este es mi portfolio',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 35, 86, 101),
                fontWeight: FontWeight.bold,
              ),
            ),

            // MENÚ EN LA ESQUINA SUPERIOR IZQUIERDA
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              child: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 28,
                  ),
                  tooltip: 'Abrir menú',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
