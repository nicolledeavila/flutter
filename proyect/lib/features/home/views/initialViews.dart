import 'package:flutter/material.dart';
import 'package:proyect/features/home/views/loadingViews.dart';
import 'package:proyect/features/home/services/api_service.dart';

void main() {
  runApp(const Initialviews());
}

enum Estado { inicial, cargando, exito, error }

class Initialviews extends StatefulWidget {
  const Initialviews({super.key});
  @override
  State<Initialviews> createState() => _InitialviewsState();
}

class _InitialviewsState extends State<Initialviews> {
  Estado estadoHeader = Estado.inicial;
  Estado estadoCard1 = Estado.inicial;
  Estado estadoCard2 = Estado.inicial;
  
  // Variables para almacenar los datos de las APIs
  Map<String, dynamic>? userData;
  Map<String, dynamic>? tasksData;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _cargarDatosIniciales();
  }

  void _cargarDatosIniciales() {
    // Iniciar en estado de carga
    setState(() {
      estadoHeader = Estado.cargando;
      estadoCard1 = Estado.cargando;
      estadoCard2 = Estado.cargando;
    });

    // Llamar a las funciones para obtener datos de las APIs
    _fetchUserData();
    _fetchTasksData();
  }

  // Función para obtener datos de la primera API (usuario) usando ApiService
  Future<void> _fetchUserData() async {
    try {
      final data = await ApiService.fetchUserData();
      setState(() {
        userData = data;
        estadoHeader = Estado.exito;
      });
    } catch (e) {
      setState(() {
        estadoHeader = Estado.error;
        errorMessage = e.toString();
      });
    }
  }

  // Función para obtener datos de la segunda API (tareas) usando ApiService
  Future<void> _fetchTasksData() async {
    try {
      final data = await ApiService.fetchTasksData();
      setState(() {
        tasksData = data;
        estadoCard1 = Estado.exito;
        estadoCard2 = Estado.exito;
      });
    } catch (e) {
      setState(() {
        estadoCard1 = Estado.error;
        estadoCard2 = Estado.error;
        errorMessage = e.toString();
      });
    }
  }

  // Función para obtener la vista del header según el estado
  Widget getHeaderVistaPorEstado(Estado estado, Widget inicial) {
    switch (estado) {
      case Estado.cargando:
        return const LoadingView();
      case Estado.exito:
        // Mostrar datos de la API cuando la carga es exitosa
        if (userData != null) {
          return Text(
            'Hola, ${userData!['nombre']}\n'
            'Contacto: ${userData!['contacto']}\n'
            'Saldo: \$${userData!['saldo']}',
            style: const TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'Datos no disponibles',
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          );
        }
      case Estado.error:
        return Text(
          errorMessage,
          style: const TextStyle(color: Colors.white, fontSize: 16),
          textAlign: TextAlign.center,
        );
      default:
        return inicial;
    }
  }

  // Función para obtener la vista de la primera tarjeta según el estado
  Widget getCard1VistaPorEstado(Estado estado, Widget inicial) {
    switch (estado) {
      case Estado.cargando:
        return const LoadingView();
      case Estado.exito:
        // Mostrar primera tarea de la segunda API
        if (tasksData != null && tasksData!['items'] != null && tasksData!['items'].length > 0) {
          final primeraTarea = tasksData!['items'][0];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                primeraTarea['titulo'] ?? 'Título no disponible',
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                primeraTarea['descripcion'] ?? 'Descripción no disponible',
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else {
          return const Text(
            'No hay tareas disponibles',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          );
        }
      case Estado.error:
        return Text(
          errorMessage,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        );
      default:
        return inicial;
    }
  }

  // Función para obtener la vista de la segunda tarjeta según el estado
  Widget getCard2VistaPorEstado(Estado estado, Widget inicial) {
    switch (estado) {
      case Estado.cargando:
        return const LoadingView();
      case Estado.exito:
        // Mostrar segunda tarea de la segunda API
        if (tasksData != null && tasksData!['items'] != null && tasksData!['items'].length > 1) {
          final segundaTarea = tasksData!['items'][1];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                segundaTarea['titulo'] ?? 'Título no disponible',
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                segundaTarea['descripcion'] ?? 'Descripción no disponible',
                style: const TextStyle(
                  color: Colors.white, 
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        } else if (tasksData != null && tasksData!['items'] != null && tasksData!['items'].length > 0) {
          // Si solo hay una tarea, mostrar mensaje
          return const Text(
            'Solo hay una tarea disponible',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No hay tareas disponibles',
            style: TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          );
        }
      case Estado.error:
        return Text(
          errorMessage,
          style: const TextStyle(color: Colors.white, fontSize: 14),
          textAlign: TextAlign.center,
        );
      default:
        return inicial;
    }
  }

  // Función para actualizar todos los datos
  Future<void> refreshAllData() async {
    setState(() {
      estadoHeader = Estado.cargando;
      estadoCard1 = Estado.cargando;
      estadoCard2 = Estado.cargando;
    });
    
    await Future.wait([_fetchUserData(), _fetchTasksData()]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Trabajo'),
          backgroundColor: const Color.fromARGB(255, 238, 31, 31),
        ),
        body: RefreshIndicator(
          onRefresh: refreshAllData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 32),
    
                // Banner rojo con datos de la primera API
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(255, 238, 31, 31),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: getHeaderVistaPorEstado(
                      estadoHeader,
                      const Text(
                        'Hola, usuario\nContacto: usuario@example.com\nSaldo: \$0',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
    
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text('Tareas', style: TextStyle(fontSize: 24))],
                  ),
                ),
    
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(8),
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.transparent,
                  ),
                  child: Column(
                    children: [
                      // Primera tarjeta (verde) con primera tarea de la API
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: Card(
                          color: Colors.green,
                          margin: EdgeInsets.zero,
                          elevation: 3,
                          child: Center(
                            child: getCard1VistaPorEstado(
                              estadoCard1,
                              const Text(
                                'Cargando tarea...',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Segunda tarjeta (azul) con segunda tarea de la API
                      SizedBox(
                        width: double.infinity,
                        height: 120,
                        child: Card(
                          color: Colors.blue,
                          margin: EdgeInsets.zero,
                          elevation: 3,
                          child: Center(
                            child: getCard2VistaPorEstado(
                              estadoCard2,
                              const Text(
                                'Cargando tarea...',
                                style: TextStyle(color: Colors.white, fontSize: 20),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Botón para recargar datos
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: refreshAllData,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Actualizar datos'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 238, 31, 31),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}