import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SubirProducto extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductoSubido;

  const SubirProducto({
    Key? key,
    required this.onProductoSubido,
  }) : super(key: key);

  @override
  _SubirProductoState createState() => _SubirProductoState();
}

class _SubirProductoState extends State<SubirProducto> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  File? imagenSeleccionada;
  String? monedaSeleccionada;

  final List<String> monedas = ['USD', 'EUR', 'MXN'];

  Future<void> seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imagen = await picker.pickImage(source: ImageSource.gallery);

    if (imagen != null) {
      setState(() {
        imagenSeleccionada = File(imagen.path);
      });
    }
  }

  void publicarProducto() {
    if (nombreController.text.isEmpty ||
        descripcionController.text.isEmpty ||
        precioController.text.isEmpty ||
        imagenSeleccionada == null ||
        monedaSeleccionada == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    final nuevoProducto = {
      'usuario': 'usuarioActual',
      'nombreProducto': nombreController.text,
      'descripcion': descripcionController.text,
      'precio': '${precioController.text} ${monedaSeleccionada!}',
      'imagen': imagenSeleccionada!.path,
    };

    widget.onProductoSubido(nuevoProducto);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir Producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: seleccionarImagen,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: Border.all(color: Colors.grey),
                    image: imagenSeleccionada != null
                        ? DecorationImage(
                            image: FileImage(imagenSeleccionada!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: imagenSeleccionada == null
                      ? const Icon(Icons.camera_alt, size: 50)
                      : null,
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
              TextField(
                controller: precioController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Precio',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: monedaSeleccionada,
                items: monedas.map((String moneda) {
                  return DropdownMenuItem<String>(
                    value: moneda,
                    child: Text(moneda),
                  );
                }).toList(),
                onChanged: (String? nuevaMoneda) {
                  setState(() {
                    monedaSeleccionada = nuevaMoneda;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Moneda',
                  border: OutlineInputBorder(),
                ),
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
