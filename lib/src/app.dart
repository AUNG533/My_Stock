// app.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mystock/src/constants/setting.dart';
import 'package:mystock/src/pages/home/home.dart';
import 'package:mystock/src/pages/login/login_page.dart';
import 'package:mystock/src/config/route.dart' as custom_route;
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: custom_route.Route.getAll(),
      title: 'My Stock',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<SharedPreferences>(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final token = snapshot.data?.getString(Setting.TOKEN_PREF) ?? '';
              if (token.isNotEmpty) {
                return HomePage();
              }
              return LoginPage();
            }
            return SizedBox();
          }),
    );
  }
}