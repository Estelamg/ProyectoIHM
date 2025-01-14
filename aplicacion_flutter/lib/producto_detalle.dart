import 'package:flutter/material.dart';
import 'dart:io';

class ProductoDetalle extends StatelessWidget {
  final String usuario;
  final String nombreProducto;
  final String descripcion;
  final String precio;
  final String imagen;
  final Function(Map<String, dynamic>) onAgregarFavoritos;
  final Function(Map<String, dynamic>) onAgregarCesta;

  const ProductoDetalle({
    super.key,
    required this.usuario,
    required this.nombreProducto,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.onAgregarFavoritos,
    required this.onAgregarCesta,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imagen.startsWith('http') || imagen.startsWith('assets/')
                ? Image.asset(
                    imagen,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : Image.file(
                    File(imagen),
                    height: 200,
                    fit: BoxFit.cover,
                  ),
            const SizedBox(height: 16),
            Text(
              nombreProducto,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Precio: $precio',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              descripcion,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    onAgregarFavoritos({
                      'nombreProducto': nombreProducto,
                      'usuario': usuario,
                      'descripcion': descripcion,
                      'precio': precio,
                      'imagen': imagen,
                    });
                  },
                  child: const Text('Añadir a Favoritos'),
                ),
                ElevatedButton(
                  onPressed: () {
                    onAgregarCesta({
                      'nombreProducto': nombreProducto,
                      'usuario': usuario,
                      'descripcion': descripcion,
                      'precio': precio,
                      'imagen': imagen,
                    });
                  },
                  child: const Text('Añadir a Cesta'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
