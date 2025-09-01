import 'package:flutter/material.dart';
import 'loadingViews.dart';
import 'errorViews.dart';
import 'successViews.dart';

void main() {
  runApp(Initialviews());
}

enum Estado { inicial, cargando, exito, error }

class Initialviews extends StatefulWidget {
  const Initialviews({super.key});
  @override
  State<Initialviews> createState() => _InitialviewsState();
}

class _InitialviewsState extends State<Initialviews> {
  Estado estadoCard1 = Estado.inicial;
  Estado estadoCard2 = Estado.inicial;

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
        appBar: AppBar(title: Text('Trabajo')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromARGB(255, 238, 31, 31),
              ),
              child: Text(
                'Hola, carlos\nContacto: carlos@example.com\nSaldo: 100',
                style: TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text('Tareas', style: TextStyle(fontSize: 24))],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.transparent,
              ),
              child: SizedBox(
                width: double.infinity,
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
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
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
