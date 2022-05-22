// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/config/route.dart' as custom_route;

class Menu {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function(BuildContext context) onTap;

  const Menu({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });
}

class MenuViewModel {
  List<Menu> get items => <Menu>[
        Menu(
          title: 'Profile',
          icon: FontAwesomeIcons.user,
          iconColor: Colors.deepOrange,
          onTap: (context){
            // todo
          }
        ),
        Menu(
          title: 'Dashboard',
          icon: FontAwesomeIcons.chartPie,
          iconColor: Colors.green,
            onTap: (context){
            Navigator.pushNamed(context, custom_route.Route.dashboard);
            }
        ),
        Menu(
          title: 'Inbox',
          icon: FontAwesomeIcons.inbox,
          iconColor: Colors.amber,
            onTap: (context){
            // todo
            }
        ),
        Menu(
          title: 'Setting',
          icon: FontAwesomeIcons.cogs,
          iconColor: Colors.blueGrey,
            onTap: (context){
            // todo
            }
        ),
      ];
}
