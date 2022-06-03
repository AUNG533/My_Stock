// management_page.dart
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late bool _isEdit;
  final _spacing = 12.0;

  @override
  void initState() {
    _isEdit = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              _buildNameInput(),
              SizedBox(height: _spacing),
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
              )
            ],
          ),
        ),
      ),
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
      );

  TextFormField _buildPriceInput() => TextFormField(
        decoration: inputStyle('price'),
      );

  TextFormField _buildStockInput() => TextFormField(
        decoration: inputStyle('stock'),
      );
}
