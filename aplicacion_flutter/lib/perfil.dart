import 'package:flutter/material.dart';
import 'favoritos.dart';
import 'cesta_screen.dart'; // Importa la nueva pantalla de la cesta
import 'dart:io';

class PerfilScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosFavoritos;
  final List<Map<String, dynamic>> productosComprados;
  final List<Map<String, dynamic>> productosSubidos;

  const PerfilScreen({
    super.key,
    required this.productosFavoritos,
    required this.productosComprados,
    required this.productosSubidos,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Column(
        children: [
          // Encabezado de perfil al estilo vintage
          Container(
            color: Colors.brown[100],
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Irene10',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'Miembro desde 2023',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text(
                          productosComprados.length.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Comprados'),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                          productosFavoritos.length.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Favoritos'),
                      ],
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Colors.grey,
                    ),
                    Column(
                      children: [
                        Text(
                          productosSubidos.length.toString(),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('Subidos'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.shopping_bag, color: Colors.orange),
                  title: const Text('Cesta'),
                  subtitle: const Text('Revisa tu historial de compras'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CestaScreen(
                          productosComprados: productosComprados,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.red),
                  title: const Text('Favoritos'),
                  subtitle: const Text('Productos que marcaste como favoritos'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
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
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.upload_file, color: Colors.blue),
                  title: const Text('Productos Subidos'),
                  subtitle: const Text('Mira tus productos publicados'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductosSubidosScreen(
                          productosSubidos: productosSubidos,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.check_circle, color: Colors.green),
                  title: const Text('Productos Comprados'),
                  subtitle: const Text('Historial de tus compras realizadas'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CestaScreen(
                          productosComprados: productosComprados,
                        ),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.blue),
                  title: const Text('Configuración'),
                  subtitle: const Text('Gestiona tus preferencias y privacidad'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navegación a configuración
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.grey),
                  title: const Text('Cerrar Sesión'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Lógica para cerrar sesión
                  },
                ),
                const Divider(height: 1),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.brown[50],
    );
  }
}

class ProductosSubidosScreen extends StatelessWidget {
  final List<Map<String, dynamic>> productosSubidos;

  const ProductosSubidosScreen({super.key, required this.productosSubidos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos Subidos'),
      ),
      body: productosSubidos.isEmpty
          ? const Center(
              child: Text(
                'No has subido productos aún.',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: productosSubidos.length,
              itemBuilder: (context, index) {
                final producto = productosSubidos[index];
                return ListTile(
                  leading: producto['imagen'] != null
                      ? Image.file(
                          File(producto['imagen']),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.image),
                  title: Text(producto['nombreProducto'] ?? 'Sin nombre'),
                  subtitle:
                      Text('${producto['precio']} - @${producto['usuario']}'),
                );
              },
            ),
    );
  }
}