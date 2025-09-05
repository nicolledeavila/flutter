import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyect/features/home/views/loadingViews.dart';
import 'package:proyect/features/home/cubit/header_cubit.dart';
import 'package:proyect/features/home/bloc/tasks_bloc.dart';

void main() {
  runApp(const Initialviews());
}

class Initialviews extends StatelessWidget {
  const Initialviews({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HeaderCubit()..loadUserData()),
        BlocProvider(create: (context) => TasksBloc()..add(LoadTasks())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Trabajo'),
            backgroundColor: const Color.fromARGB(255, 238, 31, 31),
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              // Recargar ambos estados
              context.read<HeaderCubit>().loadUserData();
              context.read<TasksBloc>().add(LoadTasks());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 32),
                  
                  // ===== PRIMER CONTAINER (Header) con CUBIT =====
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
                    child: BlocBuilder<HeaderCubit, HeaderState>(
                      builder: (context, state) {
                        if (state is HeaderLoading) {
                          return const loadingViews();
                        } else if (state is HeaderLoaded) {
                          return Text(
                            'Hola, ${state.userData['nombre']}\n'
                            'Contacto: ${state.userData['contacto']}\n'
                            'Saldo: \$${state.userData['saldo']}',
                            style: const TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          );
                        } else if (state is HeaderError) {
                          return Text(
                            state.message,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                            textAlign: TextAlign.center,
                          );
                        }
                        return const Text(
                          'Hola, usuario\nContacto: usuario@example.com\nSaldo: \$0',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        );
                      },
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

                  // ===== SEGUNDO CONTAINER (Tareas) con BLOC =====
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.all(8),
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.transparent,
                    ),
                    child: BlocBuilder<TasksBloc, TasksState>(
                      builder: (context, state) {
                        if (state is TasksLoading) {
                          return const Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  color: Colors.green,
                                  child: loadingViews(),
                                ),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  color: Colors.blue,
                                  child: loadingViews(),
                                ),
                              ),
                            ],
                          );
                        } else if (state is TasksLoaded) {
                          final tasksData = state.tasksData;
                          final items = tasksData['items'] as List? ?? [];
                          
                          return Column(
                            children: [
                              // Primera tarjeta (verde)
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  color: Colors.green,
                                  margin: EdgeInsets.zero,
                                  elevation: 3,
                                  child: Center(
                                    child: items.isNotEmpty 
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              items[0]['titulo'] ?? 'Título no disponible',
                                              style: const TextStyle(
                                                color: Colors.white, 
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              items[0]['descripcion'] ?? 'Descripción no disponible',
                                              style: const TextStyle(
                                                color: Colors.white, 
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )
                                      : const Text(
                                          'No hay tareas disponibles',
                                          style: TextStyle(color: Colors.white, fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Segunda tarjeta (azul)
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  color: Colors.blue,
                                  margin: EdgeInsets.zero,
                                  elevation: 3,
                                  child: Center(
                                    child: items.length > 1
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              items[1]['titulo'] ?? 'Título no disponible',
                                              style: const TextStyle(
                                                color: Colors.white, 
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              items[1]['descripcion'] ?? 'Descripción no disponible',
                                              style: const TextStyle(
                                                color: Colors.white, 
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        )
                                      : Text(
                                          items.isEmpty 
                                            ? 'No hay tareas disponibles'
                                            : 'Solo hay una tarea disponible',
                                          style: const TextStyle(color: Colors.white, fontSize: 16),
                                          textAlign: TextAlign.center,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else if (state is TasksError) {
                          return Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  color: Colors.green,
                                  child: Center(
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  color: Colors.blue,
                                  child: Center(
                                    child: Text(
                                      state.message,
                                      style: const TextStyle(color: Colors.white, fontSize: 14),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }
                        return const Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: Card(
                                color: Colors.green,
                                child: Center(
                                  child: Text(
                                    'Cargando tarea...',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              height: 120,
                              child: Card(
                                color: Colors.blue,
                                child: Center(
                                  child: Text(
                                    'Cargando tarea...',
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  
                  // Botón para recargar datos
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        context.read<HeaderCubit>().loadUserData();
                        context.read<TasksBloc>().add(LoadTasks());
                      },
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
      ),
    );
  }
}