import 'package:flutter/material.dart';
import '../menu/menu_lateral.dart';
import '../widgets/mi_portfolio.dart';

class BienvenidaScreen extends StatelessWidget {
  const BienvenidaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuLateral(
        onBienvenida: () {
          Navigator.pop(context);
        },
        onPortfolio: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MiPortfolio(),
            ),
          );
        },
      ),

      body: Stack(
        children: [
          // IMAGEN DE FONDO
          Positioned.fill(
            child: Image.asset(
              'assets/images/Anfiteatro.png',
              fit: BoxFit.cover,
            ),
          ),

          // TEXTOS Y BOTÓN
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Teatros\nde Canarias',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 50,
                      height: 1.1,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Cultura que nos une',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),

                  const Text(
                    'Descubre espectáculos, consulta horarios\ny vive el talento canario.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      height: 1.4,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // BOTÓN COMENZAR
                  SizedBox(
                    width: 220,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        // Conectaremos este botón más adelante.
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 1, 122, 137),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Comenzar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BOTÓN DEL MENÚ LATERAL
          Positioned(
            top: 0,
            left: 8,
            child: SafeArea(
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
          ),
        ],
      ),
    );
  }
}
