import 'package:flutter/material.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosFavoritos;

  const FavoritosScreen({super.key, required this.productosFavoritos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: productosFavoritos.isEmpty
          ? const Center(
              child: Text(
                'No hay productos en favoritos.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: productosFavoritos.length,
              itemBuilder: (context, index) {
                final producto = productosFavoritos[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  child: ListTile(
                    leading: producto['imagen'] != null
                        ? Image.asset(
                            producto['imagen'],
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image),
                    title: Text(
                      producto['nombreProducto'] ?? 'Producto sin nombre',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text('${producto['precio']} - @${producto['usuario']}'),
                  ),
                );
              },
            ),
    );
  }
}
