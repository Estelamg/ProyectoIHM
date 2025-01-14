import 'package:flutter/material.dart';
import 'dart:io';
import 'producto_detalle.dart';
import 'subir_producto_stateless.dart';
import 'perfil.dart';
import 'chat_screen.dart';
import 'cesta_screen.dart'; // Importa la pantalla de la cesta

class PaginaPrincipal extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductoComprado;
  final List<Map<String, dynamic>> favoritos;
  final Function(Map<String, dynamic>) onAgregarFavoritos;

  const PaginaPrincipal({
    super.key,
    required this.onProductoComprado,
    required this.favoritos,
    required this.onAgregarFavoritos,
  });

  @override
  State<PaginaPrincipal> createState() => _PaginaPrincipalState();
}

class _PaginaPrincipalState extends State<PaginaPrincipal> {
  List<Map<String, dynamic>> productos = [];
  List<Map<String, dynamic>> productosFiltrados = [];
  List<Map<String, dynamic>> cesta = []; // Nueva lista para la cesta
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _cargarProductos();
  }

  Future<void> _cargarProductos() async {
    setState(() {
      productos = [
        {
          'nombreProducto': 'Vintage Clock',
          'usuario': 'juan123',
          'descripcion': 'Un hermoso reloj vintage de madera.',
          'precio': '40€',
          'imagen': 'assets/images/image.png',
        },
        {
          'nombreProducto': 'Retro Lamp',
          'usuario': 'ana456',
          'descripcion': 'Lámpara retro de diseño único.',
          'precio': '30€',
          'imagen': 'assets/images/lampara.jpg',
        },
        {
          'nombreProducto': 'Antique Phone',
          'usuario': 'vintage_lover',
          'descripcion': 'Teléfono antiguo de colección.',
          'precio': '50€',
          'imagen': 'assets/images/telefono.jpg',
        },
      ];
      productosFiltrados = List.from(productos);
    });
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
            productosComprados: cesta, // Pasa la lista de productos en la cesta
            productosFavoritos: widget.favoritos,
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
          final nombre = producto['nombreProducto']?.toLowerCase() ?? '';
          final descripcion = producto['descripcion']?.toLowerCase() ?? '';
          final queryLower = query.toLowerCase();
          return nombre.contains(queryLower) || descripcion.contains(queryLower);
        }).toList();
      }
    });
  }

  void _agregarACesta(Map<String, dynamic> producto) {
    setState(() {
      if (!cesta.contains(producto)) { // Evita duplicados
        cesta.add(producto);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${producto['nombreProducto']} añadido a la cesta'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ISE Vintage',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple.shade100,
              Colors.deepPurple.shade50,
            ],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: _filtrarProductos,
                decoration: InputDecoration(
                  hintText: 'Buscar productos',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            Expanded(
              child: productosFiltrados.isEmpty
                  ? const Center(
                      child: Text(
                        'No se encontraron productos',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: productosFiltrados.length,
                      itemBuilder: (context, index) {
                        final producto = productosFiltrados[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: ListTile(
                            leading: producto['imagen'] != null
                                ? Image.asset(
                                    producto['imagen'],
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  )
                                : Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.grey[200],
                                    child: const Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.grey,
                                    ),
                                  ),
                            title: Text(
                              producto['nombreProducto'] ?? 'Sin nombre',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              '${producto['precio']} - @${producto['usuario']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.deepPurple,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_shopping_cart),
                              onPressed: () => _agregarACesta(producto),
                            ),
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
                                    onAgregarFavoritos: () {
                                      setState(() {
                                        widget.onAgregarFavoritos(producto);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${producto['nombreProducto']} añadido a favoritos'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
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
        backgroundColor: Colors.deepPurple,
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
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}
