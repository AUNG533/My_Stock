// home.dart
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import '../../constants/asset.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.name, required this.age})
      : super(key: key);

  final String name;
  final int age;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlatButton(onPressed: (){
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          }, child: Text('back'),),
          Text(widget.name),
          Text(widget.age.toString()),
          Image.asset(Asset.LOGO_IMAGE),
          Image.network(
              'https://www.somkiat.cc/wp-content/uploads/2021/08/flutter-1024x486.png'),
        ],
      ),
    );
  }
}
