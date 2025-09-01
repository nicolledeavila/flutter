import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Ocurrió un error',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
