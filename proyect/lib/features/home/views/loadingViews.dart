import 'package:flutter/material.dart';

class loadingViews extends StatelessWidget {
  const loadingViews({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 10),
          Text('Cargando...', 
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}