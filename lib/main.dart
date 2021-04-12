import 'package:flutter/material.dart';
import 'package:statistik/guru.dart';
import 'package:statistik/staf.dart';
import 'package:statistik/trend.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      navigateGuru(context);
                    },
                    child: Text('Pegawai Guru')
                ),
                ElevatedButton(
                    onPressed: () {
                      navigateStaf(context);
                    },
                    child: Text('Pegawai Staf')
                ),
                ElevatedButton(
                    onPressed: () {
                      navigateTren(context);
                    },
                    child: Text('Tren Pegawai')
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void navigateGuru(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => GuruPage()));
  }
  void navigateStaf(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => StafPage()));
  }
  void navigateTren(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => TrendPage()));
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}