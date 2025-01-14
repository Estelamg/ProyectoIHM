import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DataStore {
  static List<Map<String, dynamic>> usuarios = [];

  // Cargar usuarios desde un archivo JSON
  static Future<void> cargarUsuarios() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/usuarios.json');
      if (await file.exists()) {
        final contenido = await file.readAsString();
        usuarios = List<Map<String, dynamic>>.from(json.decode(contenido));
      }
    } catch (e) {
      print('Error al cargar usuarios: $e');
    }
  }

  // Guardar usuarios en un archivo JSON
  static Future<void> guardarUsuarios() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/usuarios.json');
      await file.writeAsString(json.encode(usuarios));
    } catch (e) {
      print('Error al guardar usuarios: $e');
    }
  }
}
