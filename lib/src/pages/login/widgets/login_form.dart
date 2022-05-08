// ignore_for_file: prefer_const_constructors
// login_form.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      // ignore: unnecessary_const
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: FormInput(),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  FormInput({Key? key}) : super(key: key);

  final TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildUserForm(),
        Divider(height: 22, thickness: 1, indent: 13, endIndent: 13),
        _buildPassword(),
      ],
    );
  }

  TextFormField _buildPassword() => TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none, // ไม่มีเส้น
          labelText: 'Password',
          labelStyle: _textStyle,
          icon: FaIcon(
            FontAwesomeIcons.lock,
            size: 22.0,
            color: Colors.black54,
          ),
        ),
        obscureText: true, // ไม่แสดงตังอักษน
      );

  TextFormField _buildUserForm() => TextFormField(
        decoration: InputDecoration(
          border: InputBorder.none, // ไม่มีเส้น
          labelText: 'Email Address',
          hintText: 'example@gmail.com',
          icon: FaIcon(
            FontAwesomeIcons.envelope,
            size: 22.0,
          ),
        ),
      );
}
