import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class SubirProducto extends StatefulWidget {
  final Function(Map<String, dynamic>) onProductoSubido;

  const SubirProducto({super.key, required this.onProductoSubido});

  @override
  _SubirProductoState createState() => _SubirProductoState();
}

class _SubirProductoState extends State<SubirProducto> {
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  final TextEditingController precioController = TextEditingController();
  File? _imagen;

  Future<void> _seleccionarImagen() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  Future<void> _tomarFoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imagen = File(pickedFile.path);
      });
    }
  }

  void _publicarProducto() {
    if (nombreController.text.isNotEmpty && precioController.text.isNotEmpty) {
      widget.onProductoSubido({
        'nombreProducto': nombreController.text,
        'usuario': 'usuarioActual',
        'descripcion': descripcionController.text,
        'precio': precioController.text,
        'imagen': _imagen?.path, // Guardar la ruta de la imagen
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Producto subido exitosamente')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor completa todos los campos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subir Producto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(
                labelText: 'Nombre del Producto',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(
                labelText: 'Precio',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _seleccionarImagen,
                  child: const Text('Seleccionar Imagen'),
                ),
                ElevatedButton(
                  onPressed: _tomarFoto,
                  child: const Text('Tomar Foto'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _imagen != null
                ? Image.file(
                    _imagen!,
                    height: 200,
                    fit: BoxFit.cover,
                  )
                : const Text('No se ha seleccionado ninguna imagen'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _publicarProducto,
                child: const Text('Publicar Producto'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
