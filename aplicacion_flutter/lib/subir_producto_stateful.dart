import 'package:flutter/material.dart';
import 'data_store.dart';

class SubirProductoStateful extends StatefulWidget {
  const SubirProductoStateful({super.key});

  @override
  State<SubirProductoStateful> createState() => _SubirProductoStatefulState();
}

class _SubirProductoStatefulState extends State<SubirProductoStateful> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  String _monedaSeleccionada = 'EUR';

  void _publicarProducto() {
    final nombre = _nombreController.text;
    final descripcion = _descripcionController.text;
    final precio = _precioController.text;

    if (nombre.isEmpty || descripcion.isEmpty || precio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    DataStore.productos.add({
      'usuario': 'usuario_actual',
      'nombreProducto': nombre,
      'descripcion': descripcion,
      'precio': '$precio $_monedaSeleccionada',
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Producto publicado exitosamente')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                color: Colors.grey[300],
                child: const Icon(
                  Icons.camera_alt,
                  size: 50,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del producto',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descripcionController,
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
                      controller: _precioController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Precio',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  DropdownButton<String>(
                    value: _monedaSeleccionada,
                    onChanged: (String? newValue) {
                      setState(() {
                        _monedaSeleccionada = newValue!;
                      });
                    },
                    items: <String>['EUR', 'USD', 'MXN']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _publicarProducto,
                child: const Text('Publicar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
