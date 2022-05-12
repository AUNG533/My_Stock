// single_sing_on.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/single_sign_on_view.dart';

class SingleSingOn extends StatelessWidget {
  const SingleSingOn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildDivider(),
        const SizedBox(height: 12),
        _buildSingleOnButton(),
      ],
    );
  }

  _buildDivider() {
    final gradientColor = [Colors.white, Colors.white10];
    // ignore: prefer_function_declarations_over_variables
    final line = (List<Color> colors) => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              stops: const [0.0, 1.0],
            ),
          ),
          width: 80,
          height: 1.0,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        line(gradientColor),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'or',
            style: TextStyle(color: Colors.white60, fontSize: 16.0),
          ),
        ),
        line(gradientColor.reversed.toList()),
      ],
    );
  }

  Padding _buildSingleOnButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // แบง space เท่ากัน
          children: SingleSignOnViewModel()
              .items
              .map(
                (item) => FloatingActionButton(
                  onPressed: item.onPress,
                  backgroundColor: item.backgroundColor,
                  child: FaIcon(
                    item.icon,
                    color: Colors.white,
                  ),
                ),
              )
              .toList(),
        ),
      );
}
