import 'package:flutter/material.dart';

class PerfilPortfolio extends StatelessWidget {
  final int opcionBody;

  const PerfilPortfolio({
    super.key,
    required this.opcionBody,
  });

  @override
  Widget build(BuildContext context) {
    final String urlImagen = opcionBody == 1
        ? 'https://cf.preview.redd.it/yesterday-i-posted-a-fake-cat-taking-a-selfie-with-my-car-v0-k9euob5uv59f1.jpg?width=1080&crop=smart&auto=webp&s=be49056853867b65baf9440f2028127dc6ff3ee2'
        : 'https://static.wikia.nocookie.net/bokunoheroacademia/images/6/6a/All_Might_sonriendo.png/revision/latest?cb=20181208073021&path-prefix=es';

    return Container(
      width: double.infinity,
      color: const Color.fromARGB(255, 9, 113, 132),
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          ClipOval(
            child: Image.network(
              urlImagen,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox(
                  width: 90,
                  height: 90,
                  child: Icon(Icons.person, size: 50),
                );
              },
            ),
          ),
          const SizedBox(width: 15),
          const Expanded(
            child: Text(
              'Hola Soy Gabriel de 2 DAM y me encanta el mar  '
              'tambien me gustan los coches y el arte',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 107, 200, 228),
              ),
            ),
          ),
        ],
      ),
    );
  }
}