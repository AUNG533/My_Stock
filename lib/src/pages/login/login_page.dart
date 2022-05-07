// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mystock/src/config/theme.dart' as custom_theme;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: custom_theme.Theme.gradient,
            ),
          ),
          Column(
            children: [
              Text('header'),
              Text('form'),
              Text('forgot password'),
              Text('SSO'),
              Text('register'),
            ],
          ),
        ],
      ),
    );
  }
}
