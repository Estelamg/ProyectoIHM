import 'package:flutter/material.dart';

class ProductoDetalle extends StatelessWidget {
  final String usuario;
  final String nombreProducto;
  final String descripcion;
  final String precio;

  const ProductoDetalle({
    super.key,
    required this.usuario,
    required this.nombreProducto,
    required this.descripcion,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre app'),
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
            Container(
              height: 200,
              width: 200,
              color: Colors.grey[300], // Color gris como fondo de la imagen
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
              '$precio€',
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
      ),
    );
  }
}
