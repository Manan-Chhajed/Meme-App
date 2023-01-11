import 'package:flutter/material.dart';
import 'package:meme_app/pages/image%20editor/image_editor_page.dart';
import 'package:meme_app/pages/image%20editor/models/text_info.dart';
import 'package:meme_app/pages/image%20editor/widgets/default_button.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();

  List<TextInfo> texts = [];

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
            text: textEditingController.text,
            color: Colors.black,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            left: 0,
            top: 0),
      );
      Navigator.of(context).pop();
    });
  }

  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text("Add New Text"),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.edit),
            filled: true,
            hintText: "Your Text Here...",
          ),
        ),
        actions: [
          DefaultButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Back"),
            color: Color.fromRGBO(53, 62, 88, 1),
            textColor: Colors.white,
          ),
          DefaultButton(
            onPressed: () {
              addNewText(context);
            },
            child: const Text("Add Text"),
            color: Color.fromRGBO(53, 62, 88, 1),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
