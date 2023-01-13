import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_app/pages/image%20editor/models/text_info.dart';
import 'package:meme_app/pages/image%20editor/widgets/default_button.dart';
import 'package:meme_app/pages/image%20editor/widgets/edit_image_view_model.dart';
import 'package:meme_app/widgets/my_button.dart';
import 'package:screenshot/screenshot.dart';

import 'widgets/image_text.dart';

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
          title: const Text("Create Meme"),
          backgroundColor: const Color.fromRGBO(53, 62, 88, 1),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Screenshot(
                  controller: screenshotController,
                  child: SizedBox(
                    child: Stack(
                      children: [
                        Image.network(widget.selectedImage),
                        // Container(
                        //   // height: MediaQuery.of(context).size.height * 0.45,
                        //   height: 350,
                        //   decoration: BoxDecoration(
                        //     color: Colors.black,
                        //     borderRadius: BorderRadius.circular(10),
                        //     image: DecorationImage(
                        //       // fit: BoxFit.cover,
                        //       image: FileImage(File(widget.selectedImage)),
                        //     ),
                        //   ),
                        // ),
                        for (int i = 0; i < texts.length; i++)
                          Positioned(
                            left: texts[i].left,
                            top: texts[i].top,
                            child: GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  currentIndex = i;
                                  removeText(context);
                                });
                              },
                              onTap: (() {
                                setCurrentIndex(context, i);
                              }),
                              child: Draggable(
                                feedback: ImageText(textInfo: texts[i]),
                                child: ImageText(textInfo: texts[i]),
                                onDragEnd: (drag) {
                                  final renderBox =
                                      context.findRenderObject() as RenderBox;
                                  Offset off =
                                      renderBox.globalToLocal(drag.offset);
                                  setState(() {
                                    texts[i].left = off.dx;
                                    texts[i].top = off.dy - 90 - 60;
                                  });
                                },
                              ),
                            ),
                          ),
                        creatorText.text.isNotEmpty
                            ? Positioned(
                                left: 0,
                                bottom: 0,
                                child: Text(
                                  creatorText.text,
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white.withOpacity(0.1),
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
                // color: Colors.red,
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  scrollDirection: Axis.horizontal,
                  children: [
                    // IconButton(
                    //   onPressed: () {},
                    //   icon: ImageIcon(
                    //     AssetImage("assets/icons/download.png"),
                    //     // color: Color.fromRGBO(53, 62, 88, 1),
                    //     size: 30,
                    //   ),
                    // ),
                    IconButton(
                      onPressed: () {
                        increaseFontSize();
                      },
                      icon: Icon(
                        Icons.add,
                        size: 30,
                      ),
                      tooltip: "Increase Font Size",
                    ),
                    IconButton(
                      onPressed: () {
                        decreaseFontSize();
                      },
                      icon: Icon(
                        Icons.remove,
                        size: 30,
                      ),
                      tooltip: "Decrease Font Size",
                    ),
                    IconButton(
                      onPressed: () {
                        alignLeft();
                      },
                      icon: Icon(
                        Icons.format_align_left,
                        size: 30,
                      ),
                      tooltip: "Align Left",
                    ),
                    IconButton(
                      onPressed: () {
                        alignCenter();
                      },
                      icon: Icon(
                        Icons.format_align_center,
                        size: 30,
                      ),
                      tooltip: "Align Center",
                    ),
                    IconButton(
                      onPressed: () {
                        alignRight();
                      },
                      icon: Icon(
                        Icons.format_align_right,
                        size: 30,
                      ),
                      tooltip: "Align Right",
                    ),
                    IconButton(
                      onPressed: () {
                        boldText();
                      },
                      icon: Icon(
                        Icons.format_bold,
                        size: 30,
                      ),
                      tooltip: "Bold",
                    ),
                    IconButton(
                      onPressed: () {
                        italicText();
                      },
                      icon: Icon(
                        Icons.format_italic,
                        size: 30,
                      ),
                      tooltip: "Italic",
                    ),
                    IconButton(
                      onPressed: () {
                        addLinesToText();
                      },
                      icon: Icon(
                        Icons.space_bar,
                        size: 30,
                      ),
                      tooltip: "Add New Line",
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: "Black",
                      child: GestureDetector(
                        onTap: () {
                          changeTextColor(Colors.black);
                        },
                        child: CircleAvatar(backgroundColor: Colors.black),
                      ),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: "White",
                      child: GestureDetector(
                        onTap: () {
                          changeTextColor(Colors.white);
                        },
                        child: CircleAvatar(backgroundColor: Colors.grey[200]),
                      ),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: "Red",
                      child: GestureDetector(
                        onTap: () {
                          changeTextColor(Colors.red);
                        },
                        child: CircleAvatar(backgroundColor: Colors.red),
                      ),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: "Blue",
                      child: GestureDetector(
                        onTap: () {
                          changeTextColor(Colors.blue);
                        },
                        child: CircleAvatar(backgroundColor: Colors.blue),
                      ),
                    ),
                    SizedBox(width: 10),
                    Tooltip(
                      message: "Green",
                      child: GestureDetector(
                        onTap: () {
                          changeTextColor(Colors.green);
                        },
                        child: CircleAvatar(backgroundColor: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: _addNewTextFab,
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          // color: Colors.grey[300],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyButton(
                  onPressed: () {
                    saveToGallery(context);
                  },
                  child: ImageIcon(
                    AssetImage("assets/icons/download.png"),
                  ),
                  color: Color.fromRGBO(53, 62, 88, 1),
                  textColor: Colors.white,
                  paddingH: 2,
                  paddingV: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: MyButton(
                    onPressed: () {
                      addNewDialog(context);
                    },
                    child: Text("Add New Text"),
                    color: Color.fromRGBO(53, 62, 88, 1),
                    textColor: Colors.white,
                    paddingH: 2,
                    paddingV: 19,
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //   child: Container(
                //     height: 55,
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5.0),
                //       color: Color.fromRGBO(53, 62, 88, 1),
                //     ),
                //     width: MediaQuery.of(context).size.width * 0.57,
                //   ),
                // ),
                MyButton(
                  onPressed: () async {},
                  child: ImageIcon(
                    AssetImage("assets/icons/share.png"),
                  ),
                  color: Color.fromRGBO(53, 62, 88, 1),
                  textColor: Colors.white,
                  paddingH: 2,
                  paddingV: 15,
                ),
              ],
            ),
          ),
        ));
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

// child: Image.file(
//   File(widget.selectedImage),
//   // fit: BoxFit.cover,
// ),
