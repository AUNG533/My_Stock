// custom_drawer.dart
// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/config/route.dart' as custom_route;
import 'package:mystock/src/viewmodels/menu_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/setting.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildProfile(),
          ..._buildMainMenu(),
          const Spacer(),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.signOutAlt,
              color: Colors.grey,
            ),
            title: const Text('Logout'),
            onTap: ShowDialogLogout,
          ),
        ],
      ),
    );
  }

  void ShowDialogLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          content: const Text('Are you sure you to log out?'),
          actions: <Widget>[
            FlatButton(
                textColor: Colors.blue,
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                }),
            FlatButton(
              textColor: Colors.red,
              child: const Text('Logout'),
              onPressed: () {
                SharedPreferences.getInstance().then((prefs) {
                  prefs.remove(Setting.TOKEN_PREF);
                });
                Navigator.of(dialogContext).pop();
                Navigator.pushNamedAndRemoveUntil(
                    context,
                    custom_route.Route.login,
                    (route) => false); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }

  UserAccountsDrawerHeader _buildProfile() => const UserAccountsDrawerHeader(
        accountName: Text('hongsar'),
        accountEmail: Text('example@gmail.ocm'),
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(
            'https://cdn-images-1.medium.com/max/140/1*X5PBTDQQ2Csztg3a6wofIQ@2x.png',
          ),
        ),
      );

  List<ListTile> _buildMainMenu() => MenuViewModel()
      .items
      .map(
        (item) => ListTile(
          title: Text(
            item.title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          leading: FaIcon(
            item.icon,
            color: item.iconColor,
          ),
          onTap: () {
            item.onTap(context);
          },
        ),
      )
      .toList();
}
