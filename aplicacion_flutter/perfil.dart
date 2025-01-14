import 'package:flutter/material.dart';
import 'favoritos.dart';

class PerfilScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosFavoritos;
  final List<Map<String, dynamic>> productosComprados;

  const PerfilScreen({
    super.key,
    required this.productosFavoritos,
    required this.productosComprados,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const CircleAvatar(radius: 40, child: Icon(Icons.person)),
                const SizedBox(height: 8),
                const Text(
                  'Usuario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite, color: Colors.red),
            title: const Text('Favoritos'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritosScreen(
                    productosFavoritos: productosFavoritos,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.green),
            title: const Text('Comprados'),
            onTap: () {
              // Implementar navegación para la lista de productos comprados
            },
          ),
        ],
      ),
    );
  }
}

