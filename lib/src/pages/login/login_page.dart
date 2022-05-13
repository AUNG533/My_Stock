// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
// login_page.dart
import 'package:flutter/material.dart';
import 'package:mystock/src/config/theme.dart' as custom_theme;
import 'package:mystock/src/pages/login/widgets/header.dart';
import 'package:mystock/src/pages/login/widgets/login_form.dart';
import 'package:mystock/src/pages/login/widgets/single_sign_on.dart';

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
          SingleChildScrollView(
            child: Column(
              children: [
                Header(),
                LoginForm(),
                SizedBox(height: 28),
                _buildFlatButton(
                  'Forgot password',
                  onPressed: () {
                    // todo
                  },
                ),
                SingleSingOn(),
                SizedBox(height: 28),
                _buildFlatButton(
                  "Don't have an Account",
                  onPressed: () {
                    // todo
                  },
                ),
                SizedBox(height: 80)
              ],
            ),
          ),
        ],
      ),
    );
  }

  FlatButton _buildFlatButton(String text,
          {required VoidCallback onPressed, double fontSize = 16}) =>
      FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: FontWeight.normal),
        ),
      );
}
