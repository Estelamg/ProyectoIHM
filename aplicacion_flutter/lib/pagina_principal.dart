import 'package:flutter/material.dart';
import 'producto_detalle.dart';
import 'subir_producto_stateless.dart';
import 'perfil.dart';
import 'chat_screen.dart';
import 'cesta_screen.dart';
import 'dart:io';

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
  List<Map<String, dynamic>> cesta = [];
  List<Map<String, dynamic>> productosSubidos = [];
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

    switch (index) {
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PerfilScreen(
              productosComprados: cesta,
              productosFavoritos: widget.favoritos,
              productosSubidos: productosSubidos,
            ),
          ),
        );
        break;
    }
  }

  void _filtrarProductos(String query) {
    setState(() {
      productosFiltrados = query.isEmpty
          ? List.from(productos)
          : productos.where((producto) {
              final nombre = producto['nombreProducto']?.toLowerCase() ?? '';
              final descripcion = producto['descripcion']?.toLowerCase() ?? '';
              final queryLower = query.toLowerCase();
              return nombre.contains(queryLower) || descripcion.contains(queryLower);
            }).toList();
    });
  }

  void _eliminarProducto(Map<String, dynamic> producto) {
    setState(() {
      productos.remove(producto);
      productosFiltrados = List.from(productos);
    });
  }

  void _agregarACesta(Map<String, dynamic> producto) {
    setState(() {
      if (!cesta.contains(producto)) {
        cesta.add(producto);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${producto['nombreProducto']} añadido a la cesta')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Bazar Vintage',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.brown.shade600,
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
              Colors.brown.shade100,
              Colors.brown.shade50,
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
                  fillColor: Colors.brown.shade200,
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
                        style: TextStyle(fontSize: 18, color: Colors.brown),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: productosFiltrados.length,
                      itemBuilder: (context, index) {
                        final producto = productosFiltrados[index];
                        return Card(
                          color: Colors.brown.shade100,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: ListTile(
                            leading: producto['imagen'] != null
                                ? (producto['imagen']
                                            .startsWith('http') ||
                                        producto['imagen']
                                            .startsWith('assets/')
                                    ? Image.asset(
                                        producto['imagen'],
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        File(producto['imagen']),
                                        height: 50,
                                        width: 50,
                                        fit: BoxFit.cover,
                                      ))
                                : Container(
                                    height: 50,
                                    width: 50,
                                    color: Colors.brown.shade300,
                                    child: const Icon(
                                      Icons.image,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                            title: Text(
                              producto['nombreProducto'] ?? 'Sin nombre',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown,
                              ),
                            ),
                            subtitle: Text(
                              '${producto['precio']} - @${producto['usuario']}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.brown,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.add_shopping_cart,
                                  color: Colors.brown),
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
                                    onAgregarFavoritos: (nuevoFavorito) {
                                      setState(() {
                                        widget.onAgregarFavoritos(nuevoFavorito);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${nuevoFavorito['nombreProducto']} añadido a favoritos'),
                                        ),
                                      );
                                    },
                                    onAgregarCesta: (nuevoProducto) {
                                      setState(() {
                                        widget.onProductoComprado(nuevoProducto);
                                      });
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${nuevoProducto['nombreProducto']} añadido a la cesta'),
                                        ),
                                      );
                                    },
                                    onProductoComprado: () {
                                      _eliminarProducto(producto);
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
                    productosSubidos.add(nuevoProducto);
                    productosFiltrados = List.from(productos);
                  });
                },
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.brown.shade600,
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
        selectedItemColor: Colors.brown.shade600,
        onTap: _onItemTapped,
      ),
    );
  }
}
