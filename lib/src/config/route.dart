// ignore_for_file: prefer_const_constructors
import 'package:flutter/cupertino.dart';
import 'package:mystock/src/pages/page.dart';

class Route{
  static const home = '/home';
  static const login = '/login';

  static Map<String, WidgetBuilder> getAll() => _route;

  static final Map<String, WidgetBuilder> _route = {
    home : (context) => const HomePage(),
    login : (context) => LoginPage(),
  };
}