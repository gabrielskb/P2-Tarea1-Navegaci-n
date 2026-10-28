import 'package:flutter/material.dart';

class MenuLateral extends StatelessWidget {
  final VoidCallback onBienvenida;
  final VoidCallback onPortfolio;

  const MenuLateral({super.key, required this.onBienvenida, required this.onPortfolio});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color.fromARGB(255, 231, 240, 246),
      width: 280,
      child: SafeArea(
        child: Column(
          children: [
            // CABECERA CON LAS MÁSCARAS TEATRALES
            SizedBox(
              width: double.infinity,
              height: 120,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/Mascaras_teatrales.png',
                      width: 75,
                      height: 75,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.theater_comedy, color: Color(0xFF20364A), size: 60);
                      },
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Teatros de Canarias',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 35, 86, 101),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const Divider(height: 1),

            // OPCIÓN: BIENVENIDA
            ListTile(
              leading: const Icon(Icons.home, color: Color(0xFF344955)),
              title: const Text('Bienvenida'),
              onTap: onBienvenida,
            ),

            // OPCIÓN: PORTFOLIO
            ListTile(
              leading: const Icon(Icons.work, color: Color(0xFF344955)),
              title: const Text('Portfolio'),
              onTap: onPortfolio,
            ),

            const Spacer(),

            // PIE CON EL PAISAJE DE MONTAÑAS
            SizedBox(
              width: double.infinity,
              height: 165,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/Paisaje_menu.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(color: Color(0xFFDCE6EC));
                    },
                  ),
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'La cultura también es\nun paisaje',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 35, 86, 101),
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
