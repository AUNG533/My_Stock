// app.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mystock/src/pages/login/login_page.dart';
import 'pages/home/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}