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
      body: ListView.builder(
        itemCount: productosFavoritos.length,
        itemBuilder: (context, index) {
          final producto = productosFavoritos[index];
          return ListTile(
            leading: producto['imagen'] != null
                ? Image.network(producto['imagen'], height: 50, width: 50)
                : const Icon(Icons.image),
            title: Text(producto['nombreProducto']),
            subtitle: Text('@${producto['usuario']}'),
          );
        },
      ),
    );
  }
}
