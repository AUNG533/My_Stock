// ignore_for_file: prefer_function_declarations_over_variables, deprecated_member_use
// product_image.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProductImage extends StatefulWidget {
  final Function(File imageFile) callBack;
  const ProductImage(this.callBack, {Key? key}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPickerImage(),
          _buildPreviewImage(),
        ],
      ),
    );
  }

  _buildPickerImage() {
    return OutlinedButton.icon(
      onPressed: () {
        _modalPickerImage();
      },
      label: const Text('image'),
      icon: const FaIcon(FontAwesomeIcons.image),
    );
  }

  dynamic _buildPreviewImage() {
    if (_imageFile == null) {
      return const SizedBox();
    }
    final container = (Widget child) => Container(
          color: Colors.grey[100],
          margin: const EdgeInsets.only(top: 4),
          alignment: Alignment.center,
          height: 350,
          child: child,
        );
    return Stack(
      children: [
        container(Image.file(_imageFile!)),
        _buildDeleteImageButton(),
      ],
    );
  }

  Positioned _buildDeleteImageButton() => Positioned(
        right: 0,
        child: IconButton(
          onPressed: () {
            setState(() {
              _imageFile = null;
            });
          },
          icon: const Icon(
            Icons.clear,
            color: Colors.black54,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      );

  void _modalPickerImage() {
    final buildListTile =
        (IconData icon, String title, ImageSource imageSource) => ListTile(
              leading: Icon(icon),
              title: Text(title),
              onTap: () {
                Navigator.pop(context);
                _pickImage(imageSource);
              },
            );
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildListTile(
            Icons.photo_camera,
            "Take a picture from camera",
            ImageSource.camera,
          ),
          buildListTile(
            Icons.photo_library,
            "Choose from photo library",
            ImageSource.gallery,
          ),
        ],
      ),
    );
  }

  void _pickImage(ImageSource imageSource) {
    _picker
        .getImage(
          source: imageSource,
          imageQuality: 70,
          maxHeight: 500,
          maxWidth: 500,
        )
        .then((file) => {
              if (file != null)
                {
                  _cropImage(file.path),
                }
            });
  }

  void _cropImage(String file) {
    ImageCropper().cropImage(
      sourcePath: file,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    ).then((file) {
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
          widget.callBack(_imageFile!);
        });
      }
    });
  }
}
