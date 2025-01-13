import 'package:flutter/material.dart';
import 'dart:io';

class FavoritosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosFavoritos;

  const FavoritosScreen({
    super.key,
    required this.productosFavoritos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: productosFavoritos.isEmpty
          ? const Center(
              child: Text(
                'No has añadido ningún producto a favoritos.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: productosFavoritos.length,
              itemBuilder: (context, index) {
                final producto = productosFavoritos[index];
                return ListTile(
                  leading: producto['imagen'] != null
                      ? Image.file(
                          File(producto['imagen']),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : Container(
                          height: 50,
                          width: 50,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image),
                        ),
                  title: Text(producto['nombreProducto']),
                  subtitle: Text('${producto['precio']}€'),
                );
              },
            ),
    );
  }
}
