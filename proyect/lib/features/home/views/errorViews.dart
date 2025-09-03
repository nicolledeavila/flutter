import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Colors.white,
          size: 40,
        ),
        SizedBox(height: 10),
        Text(
          'Error al cargar',
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}