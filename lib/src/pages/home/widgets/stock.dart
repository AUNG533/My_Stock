// ignore_for_file: prefer_const_constructors
// stock.dart
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/models/product.dart';
import 'package:mystock/src/pages/home/widgets/product_item.dart';
import 'package:mystock/src/services/network_service.dart';
import 'package:mystock/src/config/route.dart' as custom_route;

// Stateless Convert to Stateful
class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  final _spacing = 4.0;

  @override
  Widget build(BuildContext context) {
    // Wrap Scaffold / add body
    return Scaffold(
      body: _buildNetwork(), // Extract Method FutureBuilder
      // add floatingActionButton
      floatingActionButton: FloatingActionButton(
        child: FaIcon(FontAwesomeIcons.plus),
        onPressed: () {
          Navigator.pushNamed(context, custom_route.Route.management);
        },
      ),
    );
  }

  FutureBuilder<List<Product>> _buildNetwork() {
    return FutureBuilder<List<Product>>(
      future: NetworkService().getAllProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product>? product = snapshot.data;
          if (product == null || product.isEmpty) {
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
            child: _buildProductGridView(product),
          );
        }
        if (snapshot.hasError) {
          return Container(
            margin: EdgeInsets.only(top: 22),
            alignment: Alignment.topCenter,
            // child: Text(snapshot.error.toString()),
            child: Text((snapshot.error as DioError).message),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  GridView _buildProductGridView(List<Product> product) {
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
          return ProductItem(constraints.maxHeight, product: product[index]);
        },
      ),
      itemCount: product.length,
    );
  }
}
