import 'package:flutter/material.dart';
import 'individual_chat_screen.dart'; // Importar la pantalla de chat individual

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {'usuario': 'usuario1', 'mensaje': 'Hola!', 'hora': '14:20'},
      {'usuario': 'usuario2', 'mensaje': '¿Cómo estás?', 'hora': '10:15'},
      {'usuario': 'usuario3', 'mensaje': 'Buen día!', 'hora': '18:30'},
      {'usuario': 'usuario4', 'mensaje': '¿Qué tal?', 'hora': '09:42'},
      {'usuario': 'usuario5', 'mensaje': 'Nos vemos mañana.', 'hora': '01:12'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 216, 87, 130),
              child: Text(chat['usuario']![0].toUpperCase()),
            ),
            title: Text('@${chat['usuario']}'),
            subtitle: Text(chat['mensaje']!),
            trailing: Text(chat['hora']!),
            onTap: () {
              // Navega a la pantalla de chat individual
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => IndividualChatScreen(
                    usuario: chat['usuario']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
