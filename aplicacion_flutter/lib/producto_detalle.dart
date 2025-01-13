import 'dart:io';
import 'package:flutter/material.dart';

class ProductoDetalle extends StatelessWidget {
  final String usuario;
  final String nombreProducto;
  final String descripcion;
  final String precio;
  final String? imagen; // Ruta de la imagen del producto

  const ProductoDetalle({
    super.key,
    required this.usuario,
    required this.nombreProducto,
    required this.descripcion,
    required this.precio,
    this.imagen, // Parámetro opcional para la imagen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Producto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Regresa a la página anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Imagen del producto
            imagen != null
                ? Image.file(
                    File(imagen!), // Carga la imagen desde el archivo
                    height: 200,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                : Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey[300], // Fondo gris si no hay imagen
                    child: const Center(
                      child: Icon(
                        Icons.image,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
            const SizedBox(height: 16),
            // Nombre del usuario y botón de chat
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('@$usuario', style: const TextStyle(fontSize: 16)),
                ElevatedButton(
                  onPressed: () {
                    // Lógica para abrir un chat
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Abrir chat con el usuario')),
                    );
                  },
                  child: const Text('Chat'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Nombre del producto
            Text(
              nombreProducto,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Precio
            Text(
              precio,
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
            const SizedBox(height: 16),
            // Descripción
            Text(
              descripcion,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            // Botón de compra
            ElevatedButton(
              onPressed: () {
                // Lógica para realizar la compra
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Comprar producto')),
                );
              },
              child: const Text('Comprar'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          // Manejar la navegación desde la barra inferior
          switch (index) {
            case 0:
              Navigator.popUntil(context, ModalRoute.withName('/pagina_principal'));
              break;
            case 1:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar al chat')),
              );
              break;
            case 2:
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navegar al perfil')),
              );
              break;
          }
        },
      ),
    );
  }
}
