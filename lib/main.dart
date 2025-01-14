import 'package:flutter/material.dart';
import 'data_store.dart';
import 'pagina_principal.dart';
import 'login.dart';
import 'registro.dart';
import 'perfil.dart';
import 'chat_screen.dart';
import 'favoritos.dart';
import 'comprar.dart';
import 'cesta_screen.dart';
import 'pago_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataStore.cargarUsuarios();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
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
              favoritos: const [],
            ),
        '/perfil': (context) => const PerfilScreen(
              productosFavoritos: [],
              productosComprados: [],
              productosSubidos: [],
            ),
        '/chats': (context) => const ChatScreen(),
        '/favoritos': (context) => const FavoritosScreen(
              productosFavoritos: [],
            ),
        '/comprar': (context) => const ComprarScreen(
              articulosComprados: [],
            ),
        '/cesta': (context) => const CestaScreen(
              productosComprados: [],
            ),
        '/pago': (context) => const PagoScreen(
              nombreProducto: '',
              precio: '',
            ),
      },
    );
  }
}
