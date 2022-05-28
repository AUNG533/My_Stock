// image_not_found.dart
import 'package:flutter/material.dart';

class ImageNotFound extends StatelessWidget {
  const ImageNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Icon(
          Icons.image_not_supported,
          size: 50,
          color: Colors.black54,
        ),
        SizedBox(height: 8),
        Text(
          'Image Not Found',
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
