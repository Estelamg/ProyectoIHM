import 'package:flutter/material.dart';
import 'dart:io';
import 'producto_detalle.dart';
import 'subir_producto_stateless.dart';
import 'perfil.dart';
import 'chat_screen.dart';

class PaginaPrincipal extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductoComprado; // Callback para gestionar productos comprados
  final Function(Map<String, dynamic>) onAgregarFavoritos; // Callback para gestionar productos favoritos

  const PaginaPrincipal({
    super.key,
    required this.onProductoComprado,
    required this.onAgregarFavoritos,
  });

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  List<Map<String, dynamic>> productos = [];
  List<Map<String, dynamic>> productosFiltrados = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    productosFiltrados = List.from(productos); // Inicializa los productos filtrados
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ChatScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PerfilScreen(
            productosComprados: productos, // Pasar productos comprados
            productosFavoritos: [], // Añadir aquí una lista para los favoritos
          ),
        ),
      );
    }
  }

  void _filtrarProductos(String query) {
    setState(() {
      if (query.isEmpty) {
        productosFiltrados = List.from(productos);
      } else {
        productosFiltrados = productos.where((producto) {
          final nombre = producto['nombreProducto'].toLowerCase();
          final descripcion = producto['descripcion'].toLowerCase();
          final queryLower = query.toLowerCase();
          return nombre.contains(queryLower) || descripcion.contains(queryLower);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre app'),
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _filtrarProductos,
              decoration: InputDecoration(
                hintText: 'Buscar productos',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                final producto = productosFiltrados[index];
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
                          imagen: producto['imagen'],
                          onComprar: () {
                            setState(() {
                              productos.removeAt(index); // Elimina el producto de la lista principal
                              widget.onProductoComprado(producto); // Pasa el producto a "Comprados"
                              productosFiltrados = List.from(productos);
                            });
                            Navigator.pop(context); // Vuelve a la página principal
                          },
                          onAgregarFavoritos: () {
                            setState(() {
                              widget.onAgregarFavoritos(producto); // Agrega el producto a favoritos
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${producto['nombreProducto']} añadido a favoritos')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
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
                    productosFiltrados = List.from(productos);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
