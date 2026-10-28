import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'cosa_random.dart';

class ContenidoPortfolio extends StatelessWidget {
  final int opcionBody;

  const ContenidoPortfolio({super.key, required this.opcionBody});

  static const List<String> hobbiesIzquierda = [
    'Ver la puesta de sol',
    'Escuchar musica',
    'Pasear',
    'Ir a la playa',
    "'Coches'",
    'Deportes',
  ];

  static const List<String> hobbiesDerecha = [
    'Amanecer en la playa',
    'Cyberpunk',
    'ABSOLUTO CINE',
    'Mar',
    'Kebab',
    'Viajar',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(10), child: opcionBody == 0 ? construirHobbies() : construirFirefox());
  }

  Widget construirHobbies() {
    return Row(
      spacing: 30,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [construirColumnaHobbies(hobbiesIzquierda), construirColumnaHobbies(hobbiesDerecha)],
    );
  }

  Widget construirColumnaHobbies(List<String> hobbies) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: hobbies
          .map(
            (hobby) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: CosaRandom(texto: hobby),
            ),
          )
          .toList(),
    );
  }

  Widget construirFirefox() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 10,
      children: [
        Image.asset('assets/images/tipos-de-escenario.jpg', width: 300, fit: BoxFit.contain),
        const Text(
          '¡Bienvendios apagen sus moviles!',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30, color: Color.fromARGB(255, 35, 86, 101), fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(12)),
          child: QrImageView(
            data: 'https://github.com/adhernea/',
            version: QrVersions.auto,
            size: 200,
            backgroundColor: Colors.white,
            eyeStyle: const QrEyeStyle(eyeShape: QrEyeShape.square, color: Colors.black),
            dataModuleStyle: const QrDataModuleStyle(dataModuleShape: QrDataModuleShape.square, color: Colors.black),
          ),
        ),
      ],
    );
  }
}
