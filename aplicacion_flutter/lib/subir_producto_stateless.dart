import 'package:flutter/material.dart';

class SubirProductoStateless extends StatelessWidget {
  final List<Map<String, String>> productos;
  final Function(Map<String, String>) onProductoSubido;

  const SubirProductoStateless({
    super.key,
    required this.productos,
    required this.onProductoSubido,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController descripcionController = TextEditingController();
    final TextEditingController precioController = TextEditingController();
    String? monedaSeleccionada;

    void publicarProducto() {
      if (nombreController.text.isEmpty ||
          descripcionController.text.isEmpty ||
          precioController.text.isEmpty ||
          monedaSeleccionada == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor, completa todos los campos.')),
        );
        return;
      }

      final nuevoProducto = {
        'usuario': 'usuarioActual', // Sustituye con el usuario real si aplica.
        'nombreProducto': nombreController.text,
        'descripcion': descripcionController.text,
        'precio': '${precioController.text} $monedaSeleccionada',
      };

      onProductoSubido(nuevoProducto);
      Navigator.pop(context);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir Producto'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  // Aquí podrías abrir el selector de imágenes
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Función de imagen no implementada')),
                  );
                },
                child: Container(
                  height: 150,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.camera_alt, size: 50),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del producto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descripcionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: precioController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: monedaSeleccionada,
                      items: ['EUR', 'USD', 'MXN']
                          .map((moneda) => DropdownMenuItem(
                                value: moneda,
                                child: Text(moneda),
                              ))
                          .toList(),
                      onChanged: (value) {
                        monedaSeleccionada = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Moneda',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: publicarProducto,
                child: const Text('Publicar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
