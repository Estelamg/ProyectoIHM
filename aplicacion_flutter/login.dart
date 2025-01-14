import 'package:flutter/material.dart';
import 'data_store.dart';
import 'pagina_principal.dart';
import 'login.dart';
import 'registro.dart';
import 'perfil.dart';
import 'chat_screen.dart';
import 'favoritos.dart';
import 'comprar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataStore.cargarUsuarios(); // Cambiar DataStoreImpo por DataStore
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // El login será la ruta inicial
      routes: {
        '/': (context) => const LoginScreen(),
        '/registro': (context) => const Registro(),
        '/pagina_principal': (context) => PaginaPrincipal(
              onProductoComprado: (producto) {
                print("Producto comprado: $producto");
              },
              onAgregarFavoritos: (producto) {
                print("Producto añadido a favoritos: $producto");
              },
              favoritos: [], // Proporciona la lista inicial de favoritos
            ),
        '/perfil': (context) => PerfilScreen(
              productosFavoritos: [],
              productosComprados: [],
            ),
        '/chats': (context) => const ChatScreen(),
        '/favoritos': (context) => FavoritosScreen(
              productosFavoritos: [],
            ),
        '/comprar': (context) => ComprarScreen(
              articulosComprados: [],
            ),
      },
    );
  }
}
