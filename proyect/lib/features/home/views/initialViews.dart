import 'package:flutter/material.dart';
import 'loadingViews.dart';
import 'errorViews.dart';
import 'successViews.dart';

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
  // Nuevo: estado para el banner rojo
  Estado estadoHeader = Estado.inicial;

  Estado estadoCard1 = Estado.inicial;
  Estado estadoCard2 = Estado.inicial;

  @override
  void initState() {
    super.initState();

    // Al iniciar: mostrar loading en el header y en ambos banners
    setState(() {
      estadoHeader = Estado.cargando;
      estadoCard1 = Estado.cargando;
      estadoCard2 = Estado.cargando;
    });

    // Pasado un tiempo, volver al contenido inicial
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() {
        estadoHeader = Estado.inicial;
        estadoCard1 = Estado.inicial;
        estadoCard2 = Estado.inicial;
      });
    });
  }

  Widget getVistaPorEstado(Estado estado, Widget inicial) {
    switch (estado) {
      case Estado.cargando:
        return const LoadingView();
      case Estado.exito:
        return const SuccessView();
      case Estado.error:
        return const ErrorView();
      default:
        return inicial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Trabajo')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 32),

            // Banner rojo AHORA con estado
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 238, 31, 31),
              ),
              child: Center(
                child: getVistaPorEstado(
                  estadoHeader,
                  const Text(
                    'Hola, carlos\nContacto: carlos@example.com\nSaldo: 100',
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
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Card(
                      color: Colors.green,
                      margin: EdgeInsets.zero,
                      child: Center(
                        child: getVistaPorEstado(
                          estadoCard1,
                          const Text(
                            'Comprar\nir al ara',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 100,
                    child: Card(
                      color: Colors.blue,
                      margin: EdgeInsets.zero,
                      child: Center(
                        child: getVistaPorEstado(
                          estadoCard2,
                          const Text(
                            'Transito\ntramites',
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
          ],
        ),
      ),
    );
  }
}
