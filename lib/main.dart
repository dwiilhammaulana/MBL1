import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // tambahkan ini

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Catcher Game',
      home: GameScreen(), // hapus const di sini
    );
  }
}

class GameScreen extends StatelessWidget {
  const GameScreen({super.key}); // tambahkan ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Game akan ditampilkan di sini'),
      ),
    );
  }
}
