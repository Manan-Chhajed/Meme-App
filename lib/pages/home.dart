import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/text_button.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage!.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 300,
          width: 300,
          child: image != null
              ? Image.file(
                  image!,
                  height: 500,
                )
              : Container(),
        ),
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextBtn(
              text: 'Gallery',
              color: Colors.black,
              onPress: () {
                pickImage(ImageSource.gallery);
              },
            ),
            TextBtn(
              text: 'Camera',
              color: Colors.black,
              onPress: () {
                pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextBtn(
              text: 'Download',
              color: Colors.black,
              onPress: () {
                pickImage(ImageSource.gallery);
              },
            ),
            TextBtn(
              text: 'Share',
              color: Colors.black,
              onPress: () {
                pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ],
    ));
  }
}
