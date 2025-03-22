import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class CountryButton extends StatelessWidget {
  final String countryName;
  final String flagSvg;

  CountryButton({required this.countryName, required this.flagSvg});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.string(flagSvg, width: 30, height: 20),
          SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {
              if (countryName == 'Argentina') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArgentinaScreen()),
                );
              } else if (countryName == 'Chile') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChileScreen()),
                );
              } else if (countryName == 'Venezuela') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VenezuelaScreen()),
                );
              } else if (countryName == 'Brasil') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BrazilScreen()),
                );
              } else if (countryName == 'México') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MexicoScreen()),
                );
              } else if (countryName == 'Uruguay') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UruguayScreen()),
                );
              } else if (countryName == 'Bolivia') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BoliviaScreen()),
                );
              }
            },
            child: Text(countryName),
          ),
        ],
      ),
    );
  }
}

class BoliviaScreen extends StatefulWidget {
  @override
  _BoliviaScreenState createState() => _BoliviaScreenState();
}

class _BoliviaScreenState extends State<BoliviaScreen> {
  List<dynamic> exchangeRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final officialResponse = await http.get(Uri.parse('https://bo.dolarapi.com/v1/dolares/oficial'));
    final binanceResponse = await http.get(Uri.parse('https://bo.dolarapi.com/v1/dolares/binance'));

    if (officialResponse.statusCode == 200 && binanceResponse.statusCode == 200) {
      setState(() {
        exchangeRates = [
          json.decode(officialResponse.body),
          json.decode(binanceResponse.body)
        ];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Bolivia'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final rate = exchangeRates[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(rate['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Compra: \$${rate['compra'] ?? 'N/A'}'),
                        Text('Venta: \$${rate['venta'] ?? 'N/A'}'),
                        Text('Actualizado: ${rate['fechaActualizacion']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class UruguayScreen extends StatefulWidget {
  @override
  _UruguayScreenState createState() => _UruguayScreenState();
}

class _UruguayScreenState extends State<UruguayScreen> {
  List<dynamic> exchangeRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('https://uy.dolarapi.com/v1/cotizaciones'));
    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Uruguay'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final rate = exchangeRates[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(rate['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Compra: \$${rate['compra'] ?? 'N/A'}'),
                        Text('Venta: \$${rate['venta'] ?? 'N/A'}'),
                        Text('Actualizado: ${rate['fechaActualizacion']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MexicoScreen extends StatefulWidget {
  @override
  _MexicoScreenState createState() => _MexicoScreenState();
}

class _MexicoScreenState extends State<MexicoScreen> {
  Map<String, dynamic> exchangeRate = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRate();
  }

  Future<void> fetchExchangeRate() async {
    final response = await http.get(Uri.parse('https://mx.dolarapi.com/v1/cotizaciones/usd'));
    if (response.statusCode == 200) {
      setState(() {
        exchangeRate = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rate');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de México'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Card(
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(exchangeRate['nombre'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Compra: \$${exchangeRate['compra']}'),
                    Text('Venta: \$${exchangeRate['venta']}'),
                    Text('Fix: \$${exchangeRate['fix']}'),
                    Text('Actualizado: ${exchangeRate['fechaActualizacion']}'),
                  ],
                ),
              ),
            ),
    );
  }
}

class BrazilScreen extends StatefulWidget {
  @override
  _BrazilScreenState createState() => _BrazilScreenState();
}

class _BrazilScreenState extends State<BrazilScreen> {
  List<dynamic> exchangeRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('https://br.dolarapi.com/v1/cotacoes'));
    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Brasil'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final rate = exchangeRates[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(rate['nome']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Compra: \$${rate['compra']}'),
                        Text('Venta: \$${rate['venda']}'),
                        Text('Actualizado: ${rate['dataAtualizacao']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class VenezuelaScreen extends StatefulWidget {
  @override
  _VenezuelaScreenState createState() => _VenezuelaScreenState();
}

class _VenezuelaScreenState extends State<VenezuelaScreen> {
  List<dynamic> exchangeRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('https://ve.dolarapi.com/v1/dolares'));
    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Venezuela'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final rate = exchangeRates[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(rate['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Compra: \$${rate['compra']}'),
                        Text('Venta: \$${rate['venta']}'),
                        Text('Actualizado: ${rate['fechaActualizacion']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ChileScreen extends StatefulWidget {
  @override
  _ChileScreenState createState() => _ChileScreenState();
}

class _ChileScreenState extends State<ChileScreen> {
  List<dynamic> exchangeRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('https://cl.dolarapi.com/v1/cotizaciones'));
    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Chile'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final rate = exchangeRates[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(rate['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Compra: \$${rate['compra']}'),
                        Text('Venta: \$${rate['venta']}'),
                        Text('Actualizado: ${rate['fechaActualizacion']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class ArgentinaScreen extends StatefulWidget {
  @override
  _ArgentinaScreenState createState() => _ArgentinaScreenState();
}

class _ArgentinaScreenState extends State<ArgentinaScreen> {
  List<dynamic> exchangeRates = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchExchangeRates();
  }

  Future<void> fetchExchangeRates() async {
    final response = await http.get(Uri.parse('https://dolarapi.com/v1/dolares'));
    if (response.statusCode == 200) {
      setState(() {
        exchangeRates = json.decode(response.body);
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load exchange rates');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cotizaciones de Argentina'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: exchangeRates.length,
              itemBuilder: (context, index) {
                final rate = exchangeRates[index];
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(rate['nombre']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Compra: \$${rate['compra']}'),
                        Text('Venta: \$${rate['venta']}'),
                        Text('Actualizado: ${rate['fechaActualizacion']}'),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class MyApp extends StatelessWidget {
  final Map<String, String> countryFlags = {
    'Argentina': '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"><circle cx="256" cy="256" fill="#f0f0f0" r="256"/><g fill="#338af3"><path d="m256 0c-101.494 0-189.19 59.065-230.598 144.696h461.195c-41.407-85.631-129.104-144.696-230.597-144.696z"/><path d="m256 512c101.493 0 189.19-59.065 230.598-144.696h-461.196c41.408 85.631 129.104 144.696 230.598 144.696z"/></g><path d="m332.515 256-31.265 14.707 16.649 30.279-33.95-6.495-4.302 34.296-23.647-25.224-23.648 25.224-4.301-34.296-33.95 6.494 16.648-30.279-31.264-14.706 31.265-14.707-16.649-30.278 33.949 6.494 4.303-34.296 23.647 25.224 23.648-25.224 4.301 34.296 33.951-6.494-16.649 30.279z" fill="#ffda44"/></svg>
''',
    'Bolivia': '''
<svg class="w-12 h-12" enable-background="new 0 0 512 512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg"><path d="m512 256c0-31.314-5.632-61.311-15.923-89.043l-240.077-11.131-240.077 11.13c-10.291 27.733-15.923 57.73-15.923 89.044s5.632 61.311 15.923 89.043l240.077 11.131 240.077-11.13c10.291-27.733 15.923-57.73 15.923-89.044z" fill="#ffda44"></path><path d="m256 512c110.071 0 203.906-69.472 240.077-166.957h-480.154c36.171 97.485 130.006 166.957 240.077 166.957z" fill="#6da544"></path><path d="m15.923 166.957h480.155c-36.172-97.485-130.007-166.957-240.078-166.957s-203.906 69.472-240.077 166.957z" fill="#d80027"></path></svg>
''',
    'Brasil': '''
<svg class="w-12 h-12" enable-background="new 0 0 512 512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg"><circle cx="256" cy="256" fill="#6da544" r="256"></circle><path d="m256 100.174 211.478 155.826-211.478 155.826-211.478-155.826z" fill="#ffda44"></path><circle cx="256" cy="256" fill="#f0f0f0" r="89.043"></circle><g fill="#0052b4"><path d="m211.478 250.435c-15.484 0-30.427 2.355-44.493 6.725.623 48.64 40.227 87.884 89.015 87.884 30.168 0 56.812-15.017 72.919-37.968-27.557-34.497-69.958-56.641-117.441-56.641z"></path><path d="m343.393 273.06c1.072-5.524 1.651-11.223 1.651-17.06 0-49.178-39.866-89.043-89.043-89.043-36.694 0-68.194 22.201-81.826 53.899 12.05-2.497 24.526-3.812 37.305-3.812 51.717-.001 98.503 21.497 131.913 56.016z"></path></g></svg>
''',
    'Chile': '''
<svg class="size-10 sm:size-12" enable-background="new 0 0 512 512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg"><circle cx="256" cy="256" fill="#f0f0f0" r="256"></circle><path d="m512 256c0 141.384-114.616 256-256 256s-256-114.616-256-256 256 0 256 0 193.761 0 256 0z" fill="#d80027"></path><path d="m0 256c0-141.384 114.616-256 256-256v256s-166.957 0-256 0z" fill="#0052b4"></path><path d="m152.389 89.043 16.577 51.018h53.643l-43.398 31.53 16.576 51.018-43.398-31.531-43.398 31.531 16.576-51.018-43.398-31.53h53.643z" fill="#f0f0f0"></path></svg>
''',
    'México': '''
<svg class="size-10 sm:size-12" enable-background="new 0 0 512 512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg"><circle cx="256" cy="256" fill="#f0f0f0" r="256"></circle><path d="m512 256c0-101.494-59.065-189.19-144.696-230.598v461.195c85.631-41.407 144.696-129.103 144.696-230.597z" fill="#d80027"></path><g fill="#6da544"><path d="m0 256c0 101.494 59.065 189.19 144.696 230.598v-461.196c-85.631 41.408-144.696 129.104-144.696 230.598z"></path><path d="m189.217 256c0 36.883 29.9 66.783 66.783 66.783s66.783-29.9 66.783-66.783v-22.261h-133.566z"></path></g><path d="m345.043 211.478h-66.783c0-12.294-9.967-22.261-22.261-22.261s-22.261 9.967-22.261 22.261h-66.783c0 12.295 10.709 22.261 23.002 22.261h-.741c0 12.295 9.966 22.261 22.261 22.261 0 12.295 9.966 22.261 22.261 22.261h44.522c12.295 0 22.261-9.966 22.261-22.261 12.295 0 22.261-9.966 22.261-22.261h-.742c12.295 0 23.003-9.966 23.003-22.261z" fill="#ff9811"></path></svg>
''',
    'Uruguay': '''
<svg class="size-10 sm:size-12" enable-background="new 0 0 512 512" viewBox="0 0 512 512" xmlns="http://www.w3.org/2000/svg"><circle cx="256" cy="256" fill="#f0f0f0" r="256"></circle><path id="SVGCleanerId_0" d="m256 189.217h247.181c-6.419-23.814-16.175-46.255-28.755-66.783h-218.426z" fill="#338af3"></path><g fill="#338af3"><path d="m96.643 456.348h318.713c23.363-18.608 43.399-41.21 59.069-66.783h-436.851c15.671 25.572 35.707 48.175 59.069 66.783z"></path><path d="m256 0v55.652h159.357c-43.73-34.828-99.108-55.652-159.357-55.652z"></path></g><g><path id="SVGCleanerId_0_1_" d="m256 189.217h247.181c-6.419-23.814-16.175-46.255-28.755-66.783h-218.426z" fill="#338af3"></path></g><path d="m0 256c0 23.107 3.08 45.489 8.819 66.783h494.363c5.738-21.294 8.818-43.676 8.818-66.783z" fill="#338af3"></path><path d="m222.609 149.821-31.266 14.707 16.649 30.28-33.95-6.494-4.302 34.295-23.646-25.224-23.648 25.224-4.301-34.295-33.95 6.492 16.648-30.279-31.264-14.706 31.265-14.705-16.649-30.28 33.949 6.494 4.303-34.295 23.647 25.224 23.648-25.224 4.301 34.295 33.951-6.494-16.649 30.281z" fill="#ffda44"></path></svg>
''',
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App de Cotizaciones',
      home: Scaffold(
        appBar: AppBar(
          title: Text('By PINCEN.IO'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Cotizaciones de Monedas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              for (var entry in countryFlags.entries)
                CountryButton(countryName: entry.key, flagSvg: entry.value),
            ],
          ),
        ),
      ),
    );
  }
}