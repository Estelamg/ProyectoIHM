import 'package:flutter/material.dart';
import 'data_store.dart'; // Asegúrate de que este archivo contiene la clase DataStore

class Registro extends StatefulWidget {
  const Registro({super.key});

  @override
  State<Registro> createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final TextEditingController usuarioController = TextEditingController();
  final TextEditingController contrasenaController = TextEditingController();
  final TextEditingController verificarContrasenaController = TextEditingController();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController apellidosController = TextEditingController();
  final TextEditingController correoController = TextEditingController();

  void registrarUsuario() async {
    // Verificar que las contraseñas coincidan
    if (contrasenaController.text != verificarContrasenaController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    // Verificar que el usuario no exista
    final existeUsuario = DataStore.usuarios.any(
      (u) => u['usuario'] == usuarioController.text,
    );

    if (existeUsuario) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('El usuario ya existe')),
      );
      return;
    }

    // Guardar los datos en DataStore.usuarios
    DataStore.usuarios.add({
      'usuario': usuarioController.text,
      'contrasena': contrasenaController.text,
      'nombre': nombreController.text,
      'apellidos': apellidosController.text,
      'correo': correoController.text,
    });

    // Guardar los datos en el archivo JSON
    await DataStore.guardarUsuarios();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Usuario registrado correctamente')),
    );

    // Redirigir al login
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro',
          style: TextStyle(color: Colors.brown),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.brown),
          onPressed: () {
            Navigator.pop(context); // Regresa al inicio de sesión
          },
        ),
        backgroundColor: Colors.brown.shade100,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'REGISTRO',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nombreController,
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: apellidosController,
                    decoration: InputDecoration(
                      labelText: 'Apellidos',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: correoController,
                    decoration: InputDecoration(
                      labelText: 'Correo electrónico',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: usuarioController,
                    decoration: InputDecoration(
                      labelText: 'Usuario',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: contrasenaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: verificarContrasenaController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Verificar contraseña',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.brown.shade50,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: registrarUsuario,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text('Registrarse'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
