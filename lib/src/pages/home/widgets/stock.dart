// ignore_for_file: prefer_const_constructors
// stock.dart
import 'package:flutter/material.dart';
import 'package:mystock/src/models/post.dart';
import 'package:mystock/src/pages/home/widgets/product_item.dart';
import 'package:mystock/src/services/network_service.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  final _spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: NetworkService().fetchPosts(0),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post>? post = snapshot.data;
          if (post == null || post.isEmpty) {
            return Container(
              margin: EdgeInsets.only(top: 22),
              alignment: Alignment.topCenter,
              child: Text('No data'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: _buildProductGridView(post),
          );
        }
        if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.only(top: 22),
            alignment: Alignment.topCenter,
            child: Text(snapshot.error.toString()),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  GridView _buildProductGridView(List<Post> post) {
    return GridView.builder(
      padding: EdgeInsets.only(
        left: _spacing,
        right: _spacing,
        top: _spacing,
        bottom: 150,
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // จำนวน Column
        childAspectRatio: 0.8, // ขนาดแต่ละ item
        crossAxisSpacing: _spacing, // ระวาง Column
        mainAxisSpacing: _spacing,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return ProductItem(constraints.maxHeight);
        },
      ),
      itemCount: post.length,
    );
  }
}
