import 'package:flutter/material.dart';

class FavoritosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosFavoritos;

  FavoritosScreen({super.key, required this.productosFavoritos});

  @override
  Widget build(BuildContext context) {
    // Producto predeterminado para la lista de favoritos
    final List<Map<String, dynamic>> favoritosConPredeterminado = [
      {
        'nombreProducto': 'Vintage Clock',
        'usuario': 'juan123',
        'descripcion': 'Un hermoso reloj vintage de madera.',
        'precio': '40€',
        'imagen': 'assets/images/image.png', // Ruta de la imagen local
      },
      ...productosFavoritos,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoritosConPredeterminado.length,
        itemBuilder: (context, index) {
          final producto = favoritosConPredeterminado[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              leading: producto['imagen'] != null
                  ? Image.asset(
                      producto['imagen'], // Cargar imagen local
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
              subtitle: Text('@${producto['usuario']}'),
            ),
          );
        },
      ),
    );
  }
}
