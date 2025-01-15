import 'package:flutter/material.dart';
import 'dart:io';

class CestaScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosComprados;

  const CestaScreen({super.key, required this.productosComprados});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cesta',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade600,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.brown.shade100,
              Colors.brown.shade50,
            ],
          ),
        ),
        child: productosComprados.isEmpty
            ? const Center(
                child: Text(
                  'No hay productos en la cesta.',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                  ),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: productosComprados.length,
                itemBuilder: (context, index) {
                  final producto = productosComprados[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: ListTile(
                      leading: producto['imagen'] != null
                          ? (producto['imagen'].startsWith('http') || producto['imagen'].startsWith('assets/')
                              ? Image.asset(
                                  producto['imagen'],
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(producto['imagen']), // Uso correcto de File
                                  height: 50,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ))
                          : const Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.grey,
                            ),
                      title: Text(
                        producto['nombreProducto'] ?? 'Producto sin nombre',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${producto['precio']} - @${producto['usuario']}',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.brown,
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
