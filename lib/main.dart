import 'package:flutter/material.dart';
import 'package:testflutter/pages/about.dart';
import 'package:testflutter/pages/carlogin.dart';
import 'package:testflutter/pages/detail.dart';
import 'package:testflutter/pages/home.dart';
import 'package:testflutter/pages/loading.dart';
import 'package:testflutter/pages/product.dart';
import 'package:testflutter/pages/register.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TOA-CHUGOKU PAINTS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.00, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 52.00, fontStyle: FontStyle.italic),
        ),
      ),
      //home: HomePage(title: 'TOA-CHUGOKU PAINTS'),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(title: 'Main Page'),
        '/about': (context) => AboutPage(),
        '/product': (context) => ProductPage(),
        '/detail' : (context) => DetailPage(),
        '/loading' : (context) => LoadingPage(),
        '/carlogin' : (context) => CarLoginPage(),
        '/register' : (context) => RegisterPage()
      },
    );
  }
}

