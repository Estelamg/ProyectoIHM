import 'package:flutter/material.dart';
import 'individual_chat_screen.dart'; // Importar la pantalla de chat individual

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {'usuario': 'Marta123', 'mensaje': 'Hola!', 'hora': '14:20'},
      {'usuario': 'Lucaaas.5', 'mensaje': 'Te interesa el producto?', 'hora': '10:15'},
      {'usuario': 'Rafeta', 'mensaje': 'Lo quiero!', 'hora': '18:30'},
      {'usuario': 'Sandra33', 'mensaje': '¿Qué tal?', 'hora': '09:42'},
      {'usuario': 'Isa.bel', 'mensaje': 'Mañana lo envío', 'hora': '01:12'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        backgroundColor: Colors.brown.shade600,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.brown.shade100, Colors.brown.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView.builder(
          itemCount: chats.length,
          itemBuilder: (context, index) {
            final chat = chats[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.brown.shade600,
                child: Text(
                  chat['usuario']![0].toUpperCase(),
                  style: TextStyle(color: Colors.brown.shade50),
                ),
              ),
              title: Text(
                '@${chat['usuario']}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.brown.shade800),
              ),
              subtitle: Text(chat['mensaje']!,
                  style: TextStyle(color: Colors.brown.shade600)),
              trailing: Text(chat['hora']!,
                  style: TextStyle(color: Colors.brown.shade800)),
              onTap: () {
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
      ),
    );
  }
}
