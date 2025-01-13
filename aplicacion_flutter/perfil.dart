import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'comprar.dart';

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
          // Encabezado del perfil
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nombre Usuario',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '@nombre_usuario',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),

          // Opciones del perfil
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_cart, color: Colors.green),
            title: const Text('Comprados'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ComprarScreen(
                    articulosComprados: productosComprados
                        .map((producto) => producto.map(
                            (key, value) => MapEntry(key, value.toString())))
                        .toList(), // Conversión a Map<String, String>
                  ),
                ),
              );
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
