import 'package:flutter/material.dart';
import 'dart:io';
import 'producto_detalle.dart';
import 'subir_producto_stateless.dart';

class PaginaPrincipal extends StatefulWidget {
  const PaginaPrincipal({super.key});

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  List<Map<String, dynamic>> productos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre app'),
        backgroundColor: Colors.grey[800],
      ),
      body: ListView.builder(
        itemCount: productos.length,
        itemBuilder: (context, index) {
          final producto = productos[index];
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
            subtitle: Text('@${producto['usuario']}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductoDetalle(
                    usuario: producto['usuario'],
                    nombreProducto: producto['nombreProducto'],
                    descripcion: producto['descripcion'],
                    precio: producto['precio'],
                    imagen: producto['imagen'], // Pasamos la imagen aquí
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubirProducto(
                onProductoSubido: (nuevoProducto) {
                  setState(() {
                    productos.add(nuevoProducto);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
