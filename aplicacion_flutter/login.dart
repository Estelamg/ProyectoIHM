import 'package:flutter/material.dart';
import 'data_store.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usuarioController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();

  Future<void> _iniciarSesion() async {
    final usuario = _usuarioController.text.trim();
    final contrasena = _contrasenaController.text.trim();

    if (usuario.isEmpty || contrasena.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    // Verificar las credenciales en DataStore
    final usuarioRegistrado = DataStore.usuarios.firstWhere(
      (u) => u['usuario'] == usuario && u['contrasena'] == contrasena,
      orElse: () => {},
    );

    if (usuarioRegistrado.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Bienvenido, ${usuarioRegistrado['nombre']}')),
      );

      // Redirigir a la página principal
      Navigator.pushReplacementNamed(context, '/pagina_principal');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Usuario o contraseña incorrectos')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usuarioController,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _contrasenaController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Contraseña'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _iniciarSesion,
              child: const Text('Entrar'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/registro');
              },
              child: const Text('¿No tienes cuenta? Regístrate aquí'),
            ),
          ],
        ),
      ),
    );
  }
}
