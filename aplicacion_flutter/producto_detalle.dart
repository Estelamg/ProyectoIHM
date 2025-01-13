import 'dart:io';
import 'package:flutter/material.dart';

class ProductoDetalle extends StatelessWidget {
  final String usuario;
  final String nombreProducto;
  final String descripcion;
  final String precio;
  final String? imagen;
  final VoidCallback onComprar;
  final VoidCallback onAgregarFavoritos; // Callback para añadir a favoritos

  const ProductoDetalle({
    super.key,
    required this.usuario,
    required this.nombreProducto,
    required this.descripcion,
    required this.precio,
    this.imagen,
    required this.onComprar,
    required this.onAgregarFavoritos,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imagen != null
                ? Image.file(
                    File(imagen!),
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image),
                  ),
            const SizedBox(height: 16),
            Text(
              nombreProducto,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '$precio€',
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            Text(
              descripcion,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: onComprar,
                  child: const Text('Comprar'),
                ),
                ElevatedButton(
                  onPressed: onAgregarFavoritos, // Agrega a favoritos
                  child: const Text('Favoritos'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
