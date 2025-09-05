import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String userUrl =
      'https://raw.githubusercontent.com/JesusSoto7/Sotomayor/refs/heads/main/db.json';

  static const String tasksUrl =
      'https://raw.githubusercontent.com/JesusSoto7/Sotomayor/refs/heads/main/db2.json';

  // Obtener datos del usuario
  static Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse(userUrl));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar datos de usuario: ${response.statusCode}');
    }
  }

  // Obtener datos de las tareas
  static Future<Map<String, dynamic>> fetchTasksData() async {
    final response = await http.get(Uri.parse(tasksUrl));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar datos de tareas: ${response.statusCode}');
    }
  }
}