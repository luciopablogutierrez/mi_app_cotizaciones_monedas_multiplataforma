import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App de Cotizaciones',
      home: Scaffold(
        appBar: AppBar(
          title: Text('MiAppCotizaciones.com'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'API de Cotizaciones de Monedas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CountryButton(countryName: 'Argentina'),
              CountryButton(countryName: 'Chile'),
              CountryButton(countryName: 'Venezuela'),
              CountryButton(countryName: 'Uruguay'),
              CountryButton(countryName: 'México'),
              CountryButton(countryName: 'Bolivia'),
              CountryButton(countryName: 'Brasil'),
            ],
          ),
        ),
      ),
    );
  }
}

class CountryButton extends StatelessWidget {
  final String countryName;

  CountryButton({required this.countryName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {},
        child: Text(countryName),
      ),
    );
  }
}
