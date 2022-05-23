// home.dart
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:mystock/src/pages/home/widgets/chart.dart';
import 'package:mystock/src/pages/home/widgets/custom_drawer.dart';
import 'package:mystock/src/pages/home/widgets/custom_tabbar.dart';
import 'package:mystock/src/pages/home/widgets/report.dart';
import 'package:mystock/src/pages/home/widgets/stock.dart';
import 'package:mystock/src/viewmodels/tab_menu_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _tabsMenu = TabMenuViewModel().items;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabsMenu.length,
      child: Scaffold(
        appBar: _buildAppBar(),
        drawer: CustomDrawer(),
        body: TabBarView(
          children: _tabsMenu.map((item) => item.widget).toList(),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text('Stock Workshop'),
      bottom: CustomTabBar(_tabsMenu),
      actions: [
        IconButton(
          icon: Icon(Icons.bookmark_border),
          onPressed: () {
            // todo
          },
        ),
        IconButton(
          icon: Icon(Icons.qr_code),
          onPressed: () {
            // todo
          },
        ),
      ],
    );
  }
}
