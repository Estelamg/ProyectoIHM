import 'package:flutter/material.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  int _selectedTab = 0;

  final List<Map<String, String>> articulos = [
    {'nombre': 'Nombre producto', 'precio': '10'},
    {'nombre': 'Nombre producto', 'precio': '8'},
    {'nombre': 'Nombre producto', 'precio': '20'},
    {'nombre': 'Nombre producto', 'precio': '34'},
    {'nombre': 'Nombre producto', 'precio': '12.5'},
  ];

  final List<Map<String, String>> favoritos = [];
  final List<Map<String, String>> comprados = [];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> contenidoActual;

    if (_selectedTab == 0) {
      contenidoActual = articulos;
    } else if (_selectedTab == 1) {
      contenidoActual = favoritos;
    } else {
      contenidoActual = comprados;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nombre app'),
      ),
      body: Column(
        children: [
          // Encabezado del perfil
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Nombre Apellidos',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Text(
                  '@usuario',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(),
          // Pestañas
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () => setState(() => _selectedTab = 0),
                child: Column(
                  children: [
                    Text(
                      'Artículos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedTab == 0 ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (_selectedTab == 0)
                      Container(
                        height: 2,
                        width: 60,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedTab = 1),
                child: Column(
                  children: [
                    Text(
                      'Favoritos',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedTab == 1 ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (_selectedTab == 1)
                      Container(
                        height: 2,
                        width: 60,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => setState(() => _selectedTab = 2),
                child: Column(
                  children: [
                    Text(
                      'Comprados',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _selectedTab == 2 ? Colors.black : Colors.grey,
                      ),
                    ),
                    if (_selectedTab == 2)
                      Container(
                        height: 2,
                        width: 60,
                        color: Colors.black,
                      ),
                  ],
                ),
              ),
            ],
          ),
          const Divider(),
          // Contenido actual (Artículos, Favoritos, Comprados)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              itemCount: contenidoActual.length + (_selectedTab == 0 ? 1 : 0),
              itemBuilder: (context, index) {
                if (_selectedTab == 0 && index == contenidoActual.length) {
                  return GestureDetector(
                    onTap: () {
                      // Lógica para añadir un nuevo artículo
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey[200],
                      ),
                      child: const Center(
                        child: Icon(Icons.add, size: 30, color: Colors.grey),
                      ),
                    ),
                  );
                }
                final producto = contenidoActual[index];
                return Column(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      producto['nombre']!,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${producto['precio']}€',
                      style: const TextStyle(fontSize: 14, color: Colors.green),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
        currentIndex: 2, // Perfil seleccionado
        onTap: (index) {
          if (index == 0) {
            Navigator.pushNamed(context, '/pagina_principal');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/chats');
          }
        },
      ),
    );
  }
}
