import 'package:flutter/material.dart';

class NavegacionPortfolio extends StatelessWidget {
  final int opcionSeleccionada;
  final ValueChanged<int> onCambiarSeccion;

  const NavegacionPortfolio({
    super.key,
    required this.opcionSeleccionada,
    required this.onCambiarSeccion,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => onCambiarSeccion(0),
                style: ElevatedButton.styleFrom(
                   backgroundColor: const Color.fromARGB(255, 35, 86, 101),
                  foregroundColor: Color.fromARGB(255, 231, 240, 246),
                  minimumSize: const Size(0, 50),
                ),
                child: const Text('Mis jobis'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => onCambiarSeccion(1),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 35, 86, 101),
                  foregroundColor: Color.fromARGB(255, 231, 240, 246),
                  minimumSize: const Size(0, 50),
                ),
                child: const Text('My repositorio'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}