// ignore_for_file: prefer_const_constructors
// login_form.dart

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/config/theme.dart' as custom_theme;
import 'package:mystock/src/pages/home/home.dart';
import 'package:mystock/src/utils/regex_validator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController? usernameController;
  TextEditingController? passwordController;

  String? _errorUsername;
  String? _errorPassword;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    usernameController?.dispose();
    passwordController?.dispose();
    super.dispose();
  }

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
          padding:
              const EdgeInsets.only(top: 20, bottom: 58, left: 20, right: 20),
          child: FormInput(
            usernameController: usernameController,
            passwordController: passwordController,
            errorUsername: _errorUsername ?? '',
            errorPassword: _errorPassword ?? '',
          ),
        ),
      );

  Container _buildSubmitButton() => Container(
        width: 220,
        height: 50,
        decoration: _boxDecoration(),
        // ignore: deprecated_member_use
        child: FlatButton(
          onPressed: _onLogin,
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

  void showAlertBar() {
    Flushbar(
      title: "Username or Password is incorrect",
      message: 'Please try again.',
      icon: Icon(
        Icons.error,
        size: 28.0,
        color: Colors.red,
      ),
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(10),
      borderRadius: BorderRadius.circular(10),
    ).show(context);
  }

  void showLoading() {
    Flushbar(
      message: 'Loading...',
      showProgressIndicator: true,
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  void _onLogin() {
    String? username = usernameController?.text;
    String? password = passwordController?.text;

    _errorUsername = null;
    _errorPassword = null;

    if (!EmailSubmitRegexValidator().isValid(username!)) {
      _errorUsername = "The Email be a valid email.";
    }
    if (password!.length < 8) {
      _errorPassword = "Mute be at least 8 characters";
    }
    if (_errorUsername == null && _errorPassword == null) {
      showLoading();
      Future.delayed(Duration(seconds: 2)).then((value) {
        Navigator.pop(context);
        if (username == 'example@gmail.com' && password == '12345678') {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(name: 'Non', age: 40,),
            ),
          );
        } else {
          showAlertBar();
        }
      });
    } else {
      setState(() {});
    }
  }
}

class FormInput extends StatefulWidget {
  final TextEditingController? usernameController;
  final TextEditingController? passwordController;
  final String errorUsername;
  final String errorPassword;

  const FormInput({
    Key? key,
    @required this.usernameController,
    @required this.passwordController,
    required this.errorUsername,
    required this.errorPassword,
  }) : super(key: key);

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  final TextStyle _textStyle = TextStyle(
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  bool? _obscureTextPassword;
  FocusNode? _passwordFocusNode;

  @override
  void initState() {
    _obscureTextPassword = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //_buildUserForm(),
        _buildUsername(),
        Divider(height: 22, thickness: 1, indent: 13, endIndent: 13),
        _buildPassword(),
      ],
    );
  }

  TextFormField _buildPassword() => TextFormField(
        focusNode: _passwordFocusNode,
        controller: widget.passwordController,
        decoration: InputDecoration(
          border: InputBorder.none,
          // ไม่มีเส้น
          labelText: 'Password',
          labelStyle: _textStyle,
          icon: FaIcon(
            FontAwesomeIcons.lock,
            size: 22.0,
            color: Colors.black54,
          ),
          errorText: widget.errorPassword,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureTextPassword = !_obscureTextPassword!;
              });
            },
            icon: FaIcon(
              _obscureTextPassword!
                  ? FontAwesomeIcons.eye
                  : FontAwesomeIcons.eyeSlash,
              color: Colors.black54,
              size: 15.0,
            ),
          ),
        ),
        obscureText: _obscureTextPassword!, // ไม่แสดงตังอักษน
      );

  TextFormField _buildUsername() => TextFormField(
        controller: widget.usernameController,
        decoration: InputDecoration(
          border: InputBorder.none,
          // ไม่มีเส้น
          labelText: 'Email Address',
          hintText: 'example@gmail.com',
          icon: FaIcon(
            FontAwesomeIcons.envelope,
            size: 22.0,
          ),
          errorText: widget.errorUsername,
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        onFieldSubmitted: (String value) {
          FocusScope.of(context).requestFocus(_passwordFocusNode);
        },
      );
}
