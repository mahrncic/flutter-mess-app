import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mess_app/constants/constants.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickFn;
  final NetworkImage initialFile;
  final String uploadText;

  UserImagePicker(this.imagePickFn, this.uploadText, {this.initialFile});

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickFn(pickedImageFile);
  }

  ImageProvider<Object> getCurrentImage() {
    if (_pickedImage != null) {
      return FileImage(_pickedImage);
    }
    if (widget.initialFile != null) {
      return widget.initialFile;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: Colors.grey,
          backgroundImage: getCurrentImage(),
        ),
        FlatButton.icon(
          textColor: kPrimaryColor,
          onPressed: _pickImage,
          icon: const Icon(Icons.image),
          label: Text(widget.uploadText),
        ),
      ],
    );
  }
}
