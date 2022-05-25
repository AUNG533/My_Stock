// ignore_for_file: prefer_const_constructors
// stock.dart
import 'package:flutter/material.dart';
import 'package:mystock/src/pages/home/widgets/product_item.dart';

class Stock extends StatelessWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // จำนวน Column
        childAspectRatio: 0.8, // ขนาดแต่ละ item
        crossAxisSpacing: 5, // ระวาง Column
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return ProductItem(constraints.maxHeight);
        },
      ),
      itemCount: 5,
    );
  }
}
