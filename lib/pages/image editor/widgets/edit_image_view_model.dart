import 'package:flutter/material.dart';
import 'package:meme_app/pages/image%20editor/image_editor_page.dart';
import 'package:meme_app/pages/image%20editor/models/text_info.dart';
import 'package:meme_app/pages/image%20editor/widgets/default_button.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();

  List<TextInfo> texts = [];
  int currentIndex = 0;

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });

    // SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromRGBO(72, 83, 68, 1),
        content: Text(
          "Selected For Styling",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Deleted',
          style: TextStyle(
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontStyle == FontStyle.italic) {
        texts[currentIndex].fontStyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontStyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  addNewText(BuildContext context) {
    setState(() {
      texts.add(
        TextInfo(
            text: textEditingController.text,
            color: Colors.white,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.normal,
            fontSize: 20,
            textAlign: TextAlign.left,
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
