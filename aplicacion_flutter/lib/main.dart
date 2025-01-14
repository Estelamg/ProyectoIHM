import 'package:flutter/material.dart';
import 'data_store.dart';
import 'pagina_principal.dart';
import 'login.dart';
import 'registro.dart';
import 'perfil.dart';
import 'chat_screen.dart';
import 'favoritos.dart';
import 'comprar.dart';
import 'cesta_screen.dart'; // Importa la pantalla de la cesta
import 'pago_screen.dart'; // Importa la pantalla de pago

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
              favoritos: const [], // Proporciona la lista inicial de favoritos
            ),
        '/perfil': (context) => PerfilScreen(
              productosFavoritos: [],
              productosComprados: [],
            ),
        '/chats': (context) => const ChatScreen(),
        '/favoritos': (context) => FavoritosScreen(
              productosFavoritos: const [],
            ),
        '/comprar': (context) => const ComprarScreen(
              articulosComprados: [],
            ),
        '/cesta': (context) => CestaScreen(
              productosComprados: [], // Proporciona la lista inicial de productos comprados
            ),
        '/pago': (context) => const PagoScreen( // Ruta para la pantalla de pago
              nombreProducto: '', // Valores por defecto
              precio: '',
            ),
      },
    );
  }
}
