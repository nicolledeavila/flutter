import 'package:flutter/material.dart';
import 'package:proyect/features/home/views/errorViews.dart';
import 'package:proyect/features/home/views/initialViews.dart';
import 'package:proyect/features/home/views/loadingViews.dart';
import 'package:proyect/features/home/views/successViews.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ErrorView(),
    );
  }
}
