import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meme_app/pages/firebase/show_templates.dart';
import 'package:meme_app/pages/firebase/storage_service.dart';
import 'package:meme_app/widgets/my_button.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../../widgets/text_button.dart';
import '../ads/ads_page.dart';

class UserSettings extends StatefulWidget {
  const UserSettings({super.key});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();
    return Scaffold(
      body: Column(
        children: [
          MyButton(
            onPressed: () async {
              final results =
                  await ImagePicker().pickImage(source: ImageSource.gallery);

              if (results == null) return;

              final path = results.path;
              final fileName = results.name;

              storage.uploadFile(path, fileName).then(
                    (value) => print("done.................................."),
                  );
            },
            child: Text("Upload file"),
            color: Colors.black,
            textColor: Colors.white,
            paddingH: 0,
            paddingV: 0,
          ),
          FutureBuilder(
            future: storage.listFiles(),
            builder: (BuildContext context,
                AsyncSnapshot<firebase_storage.ListResult> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: snapshot.data!.items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          onPressed: (() {}),
                          child: Text(snapshot.data!.items[index].name),
                        ),
                      );
                    },
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container(
                color: Colors.red,
              );
            },
          ),
          FutureBuilder(
            future:
                storage.downloadURL('saala ye dukh kahe khatam nahi hota.jpg'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return Container(
                  width: 300,
                  height: 250,
                  child: Image.network(snapshot.data!, fit: BoxFit.cover),
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return Container(
                color: Colors.red,
              );
            },
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ShowTemplates()));
              },
              child: Text("Press"))
        ],
      ),
    );
  }
}
