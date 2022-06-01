// ignore_for_file: prefer_const_declarations, prefer_const_constructors, prefer_const_literals_to_create_immutables
// product_item.dart
import 'package:flutter/material.dart';
import 'package:mystock/src/models/product.dart';
import 'package:mystock/src/utils/format.dart';
import 'package:mystock/src/widgets/image_not_found.dart';

import '../../../constants/api.dart';

class ProductItem extends StatelessWidget {
  final double maxHeight;

  final Product product;

  const ProductItem(this.maxHeight, {Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('xxx');
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            _buildImage(),
            _buildInfo(),
          ],
        ),
      ),
    );
  }

  Stack _buildImage() {
    final height = maxHeight * 0.7;
    final productImage = product.image;

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: height,
          child: productImage != null && productImage.isNotEmpty
              ? Image.network('${API.IMAGE_URL}/$productImage')
              : ImageNotFound(),
        ),
        if (product.stock! <= 0) _buildOutOfStock(),
      ],
    );
  }

  Expanded _buildInfo() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
               product.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '฿${formatCurrent.format(product.price)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${formatNumber.format(product.stock)} pieces',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrangeAccent,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  Positioned _buildOutOfStock() => Positioned(
        top: 2,
        right: 2,
        child: Card(
          color: Colors.amber,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              'out of stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
}
