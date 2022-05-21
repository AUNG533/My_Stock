// home.dart
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mystock/src/pages/home/widgets/custom_drawer.dart';
import '../../constants/asset.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stock Workshop'),
      ),
      drawer: CustomDrawer(),
      body: Image.asset(Asset.LOGO_IMAGE),
    );
  }
}
