import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' show Response, get;

import 'siniflar/anlik_gunluk_saatlik.dart';
import 'siniflar/hava.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AnlikGunlukSaatlik _anlikGunlukSaatlik;

  Future<void> _incrementCounter() async {
    String adres =
        "https://api.openweathermap.org/data/2.5/onecall?lat=64.20084&lon=-149.4936717&appid=5e6cd7584bee25e9d7f28e9edbbd0709&units=metric&lang=en&exclude=minutely";
    Response cevap = await get(adres);
    Map gelenJson;
    if (cevap.statusCode == 200) {
      gelenJson = jsonDecode(cevap.body);
    } else {
      gelenJson = jsonDecode(await rootBundle.loadString('assets/data.json'));
    }

    _anlikGunlukSaatlik = AnlikGunlukSaatlik.fromJson(gelenJson);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          Text(
            'Gelen Cevap:',
            style: Theme.of(context).textTheme.headline4,
          ),
          if (_anlikGunlukSaatlik != null)
            for (Hava hava in _anlikGunlukSaatlik.anlik.hava)
              Text(
                hava.olay,
                style: Theme.of(context).textTheme.headline4,
              ),
          if (_anlikGunlukSaatlik != null)
            Text(
              _anlikGunlukSaatlik.saatlik.length.toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
