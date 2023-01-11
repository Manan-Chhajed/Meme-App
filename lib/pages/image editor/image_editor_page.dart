import 'dart:io';

import 'package:flutter/material.dart';
import 'package:meme_app/pages/image%20editor/widgets/edit_image_view_model.dart';

class EditImageScreen extends StatefulWidget {
  EditImageScreen({required this.selectedImage, super.key});

  final String selectedImage;

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Edit Image"),
        backgroundColor: const Color.fromRGBO(53, 62, 88, 1),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.45,
              height: 350,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  // fit: BoxFit.cover,
                  image: FileImage(File(widget.selectedImage)),
                ),
              ),
              // child: Image.file(
              //   File(widget.selectedImage),
              //   // fit: BoxFit.cover,
              // ),
            ),
          ),
          Expanded(
            child: ListView(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: const [
                SizedBox(
                  width: 20,
                ),
                Chip(
                  label: Icon(Icons.home),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                SizedBox(
                  width: 20,
                ),
                Chip(
                  label: Icon(Icons.home),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                SizedBox(
                  width: 20,
                ),
                Chip(
                  label: Icon(Icons.home),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
                SizedBox(
                  width: 20,
                ),
                Chip(
                  label: Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  backgroundColor: Color.fromRGBO(93, 131, 116, 1),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _addNewTextFab,
    );
  }

  Widget get _addNewTextFab {
    return FloatingActionButton(
      onPressed: () {
        addNewDialog(context);
      },
      backgroundColor: const Color.fromRGBO(53, 62, 88, 1),
      tooltip: "Add New Text",
      child: const Icon(
        Icons.edit,
        color: Colors.white,
      ),
    );
  }
}
