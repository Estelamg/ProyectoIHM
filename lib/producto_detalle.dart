import 'package:flutter/material.dart';
import 'dart:io';
import 'pago_screen.dart';

class ProductoDetalle extends StatelessWidget {
  final String usuario;
  final String nombreProducto;
  final String descripcion;
  final String precio;
  final String imagen;
  final Function(Map<String, dynamic>) onAgregarFavoritos;
  final Function(Map<String, dynamic>) onAgregarCesta;
  final Function() onProductoComprado;

  const ProductoDetalle({
    super.key,
    required this.usuario,
    required this.nombreProducto,
    required this.descripcion,
    required this.precio,
    required this.imagen,
    required this.onAgregarFavoritos,
    required this.onAgregarCesta,
    required this.onProductoComprado,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        backgroundColor: Colors.brown.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade100, Colors.brown.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Precio: $precio',
              style: TextStyle(fontSize: 20, color: Colors.brown.shade700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              descripcion,
              style: TextStyle(fontSize: 16, color: Colors.brown.shade600),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    onAgregarFavoritos({
                      'nombreProducto': nombreProducto,
                      'usuario': usuario,
                      'descripcion': descripcion,
                      'precio': precio,
                      'imagen': imagen,
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.brown.shade600),
                    foregroundColor: Colors.brown.shade600,
                  ),
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown.shade600,
                    foregroundColor: Colors.brown.shade50,
                  ),
                  child: const Text('Añadir a Cesta'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                onProductoComprado();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PagoScreen(
                      nombreProducto: nombreProducto,
                      precio: precio,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.brown.shade50,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Comprar'),
            ),
          ],
        ),
      ),
    );
  }
}
