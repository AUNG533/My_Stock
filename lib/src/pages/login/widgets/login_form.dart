// ignore_for_file: prefer_const_constructors
// login_form.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/config/theme.dart' as custom_theme;

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        buildForm(),
        _buildSubmitButton(),
      ],
    );
  }

  Card buildForm() => Card(
        margin: EdgeInsets.only(top: 22, left: 22, right: 22, bottom: 20),
        elevation: 2.0, // เง่า
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // โคงมุง
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 58, left: 20, right: 20),
          child: FormInput(),
        ),
      );

  Container _buildSubmitButton() => Container(
        width: 220,
        height: 50,
        decoration: _boxDecoration(),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            "LOGIN",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );

  BoxDecoration _boxDecoration() {
    const gradientStart = custom_theme.Theme.gradientStart;
    const gradientEnd = custom_theme.Theme.gradientEnd;

    _boxShadowItem(Color color) => BoxShadow(
          color: color,
          offset: Offset(1.0, 6.0),
          blurRadius: 20.0,
        );

    return BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(5.0)),
      boxShadow: [
        _boxShadowItem(gradientStart),
        _boxShadowItem(gradientEnd),
      ],
      gradient: LinearGradient(
        colors: const [
          gradientEnd,
          gradientStart,
        ],
        begin: const FractionalOffset(0.0, 0.0),
        end: const FractionalOffset(1.0, 1.0),
        stops: const [0.0, 1.0],
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
