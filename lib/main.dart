import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Mi App'),
        ),
        body: Center(
          child: Text('¡Hola, mundo!'),
        ),
      ),
    );
  }
}
