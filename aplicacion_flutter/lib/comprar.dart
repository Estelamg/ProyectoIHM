import 'package:flutter/material.dart';

class ComprarScreen extends StatelessWidget {
  final List<Map<String, String>> articulosComprados;

  const ComprarScreen({
    super.key,
    required this.articulosComprados,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artículos Comprados'),
      ),
      body: articulosComprados.isEmpty
          ? const Center(
              child: Text(
                'No has comprado ningún artículo aún.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              itemCount: articulosComprados.length,
              itemBuilder: (context, index) {
                final articulo = articulosComprados[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image),
                    ),
                    title: Text(
                      articulo['nombre']!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${articulo['precio']}€'),
                  ),
                );
              },
            ),
    );
  }
}
