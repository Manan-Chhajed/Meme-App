import 'dart:io';
// import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:meme_app/pages/image%20editor/image_editor_page.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../../widgets/text_button.dart';

class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  String headerText = "Header Text";
  String footerText = "Footer Text";

  File? image;
  final controller = ScreenshotController();

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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              color: Colors.black,
              height: 350,
              width: 350,
              child: buildImage(),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (val) {
                setState(() {
                  headerText = val;
                });
              },
              decoration: InputDecoration(
                hintText: "Header Text",
              ),
            ),
            SizedBox(height: 12),
            TextField(
              onChanged: (val) {
                setState(() {
                  footerText = val;
                });
              },
              decoration: InputDecoration(
                hintText: "Footer Text",
              ),
            ),
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
                  onPress: () async {
                    final image =
                        await controller.captureFromWidget(buildImage());
                    if (image == null) return;

                    await saveImage(image);
                    // saveAndShare(image);
                  },
                ),
                TextBtn(
                  text: 'Edit Image mf',
                  color: Colors.black,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EditImageScreen(selectedImage: image!.path)));
                  },
                ),
              ],
            ),
            const SizedBox(height: 500),
            Container(
              height: 200,
              color: Colors.red,
              child: Text("Hello"),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> saveImage(Uint8List bytes) async {
    await [Permission.storage].request();

    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(bytes, name: name);

    return result('filePath');
  }

  Widget buildImage() {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: image != null
              ? Image.file(
                  image!,
                  height: 500,
                )
              : Container(),
        ),
        // Container(
        //   child: Column(
        //     children: [
        //       Text(headerText,
        //           style: TextStyle(fontSize: 52, color: Colors.amber)),
        //       Spacer(),
        //       Text(
        //         footerText,
        //         style: TextStyle(fontSize: 52, color: Colors.amber),
        //       ),
        //     ],
        //   ),
        // ),
        Positioned(
          top: 16,
          right: 0,
          left: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black,
              child: Text(
                headerText,
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 0,
          left: 0,
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.black,
              child: Text(
                footerText,
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future saveAndShare(Uint8List bytes) async {
    // await Share.shareFiles([image.path]);
    // final box = context.findRenderObject() as RenderBox?;
    // await Share.share("text",
    //     subject: "subject",
    //     sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
