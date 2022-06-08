// management_page.dart
// ignore_for_file: prefer_const_constructors
import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mystock/src/models/product.dart';
import 'package:mystock/src/pages/manament/widgets/product_image.dart';
import 'package:mystock/src/services/network_service.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late bool _isEdit;
  final _spacing = 12.0;
  Product? _product;
  final _form = GlobalKey<FormState>();
  File? _imageFile;

  @override
  void initState() {
    _isEdit = false;
    _product = Product(id: 0, image: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments; // รับค่า จาก product_item
    if (arguments is Product) {
      _isEdit = true;
      _product = arguments; // ค่า product จาก product_item
    }

    return Scaffold(
      appBar: _buildAppBar(), // ExtractMethod AppBar
      body: SingleChildScrollView(
        child: Form(
          key: _form,
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
                ),
                SizedBox(height: _spacing),
                ProductImage(
                  callBack,
                  _product!.image,
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  callBack(File imageFile) {
    _imageFile = imageFile;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'), // แสดง title ตาม event
      actions: [
        if (_isEdit) _buildDeleteButton(),
        FlatButton(
          textColor: Colors.white,
          onPressed: () {
            _form.currentState?.save();
            FocusScope.of(context).requestFocus(FocusNode()); // ปิก keybord
            if (_isEdit) {
              editProduct();
            } else {
              addProduct();
            }
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
        initialValue: _product!.name,
        decoration: inputStyle('name'),
        onSaved: (String? value) {
          _product!.name = value!.isEmpty ? '-' : value;
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        initialValue: _product!.price?.toString(),
        decoration: inputStyle('price'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product!.price = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        initialValue: _product!.stock?.toString(),
        decoration: inputStyle('stock'),
        keyboardType: TextInputType.number,
        onSaved: (String? value) {
          _product!.stock = value!.isEmpty ? 0 : int.parse(value);
        },
      );

  void addProduct() {
    NetworkService()
        .addProduct(_product!, imageFile: _imageFile)
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }

  void showAlertBar(String message,
      {IconData icon = FontAwesomeIcons.checkCircle,
      Color color = Colors.green}) {
    Flushbar(
      message: message,
      icon: FaIcon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    ).show(context);
  }

  IconButton _buildDeleteButton() => IconButton(
        icon: Icon(Icons.delete_outline),
        onPressed: () {
          // Dialog แจ้งเติม
          showDialog<void>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: Text('Delete Product'),
                content: Text('Are you sure you want to delete?'),
                actions: <Widget>[
                  // ปุงยกเลิก
                  FlatButton(
                    child: Text('cancel'),
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                    },
                  ),
                  // ปุงตกลง ลบ
                  FlatButton(
                    child: Text(
                      'ok',
                      style: TextStyle(color: Colors.red),
                    ),
                    onPressed: () { // ออก และ เรียอกใช้ function delete
                      Navigator.of(dialogContext).pop();
                      deleteProduct();  // Dismiss alert dialog
                    },
                  ),
                ],
              );
            },
          );
        },
      );

  void deleteProduct() {
    NetworkService().deleteProduct(_product!.id).then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }

  void editProduct() {
    NetworkService()
        .editProduct(_product!, imageFile: _imageFile!)
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(
        error.toString(),
        icon: FontAwesomeIcons.timesCircle,
        color: Colors.red,
      );
    });
  }
}
