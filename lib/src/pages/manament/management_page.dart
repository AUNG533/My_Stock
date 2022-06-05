// management_page.dart
// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:mystock/src/models/product.dart';
import 'package:mystock/src/pages/manament/widgets/product_image.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late bool _isEdit;
  final _spacing = 12.0;
  late Product _product;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _isEdit = false;
    _product = Product();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(), // ExtractMethod AppBar
      body: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildNameInput(),
              Row(
                children: [
                  Flexible(
                    child: _buildPriceInput(),
                  ),
                  SizedBox(width: _spacing),
                  Flexible(
                    child: _buildStockInput(),
                  ),
                ],
              ),
              SizedBox(height: _spacing),
              ProductImage(),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      actions: [
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            _form.currentState?.save();
            print(_product.name);
            print(_product.price);
            print(_product.stock);
          },
          child: Text('submit'),
        ),
      ],
    );
  }

  InputDecoration inputStyle(label) => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black12,
            width: 2,
          ),
        ),
        labelText: label,
      );

  TextFormField _buildNameInput() => TextFormField(
        decoration: inputStyle('name'),
        onSaved: (String? value) {
          _product.name = value!.isEmpty ? '-' : value;
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        decoration: inputStyle('price'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product.price = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        decoration: inputStyle('stock'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product.stock = value!.isEmpty ? 0 : int.parse(value);
        },
      );
}
