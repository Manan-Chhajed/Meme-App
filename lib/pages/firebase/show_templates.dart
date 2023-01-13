import 'package:flutter/material.dart';
import 'package:meme_app/pages/firebase/firebase_api.dart';
import 'package:meme_app/pages/firebase/models/firebase_file.dart';
import 'package:meme_app/pages/image%20editor/image_editor_page.dart';

class ShowTemplates extends StatefulWidget {
  const ShowTemplates({super.key});

  @override
  State<ShowTemplates> createState() => _ShowTemplatesState();
}

class _ShowTemplatesState extends State<ShowTemplates> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseApi.listAll("meme templates/");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<FirebaseFile>>(
        future: futureFiles,
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text("Some error occured"));
              } else {
                final files = snapshot.data;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: files!.length,
                        itemBuilder: ((context, index) {
                          final file = files[index];
                          return buildFile(context, file);
                        }),
                      ),
                    ),
                  ],
                );
              }
          }
        }),
      ),
    );
  }

  Widget buildFile(BuildContext cotext, FirebaseFile file) {
    return ListTile(
      leading: Image.network(file.url),
      title: Text(file.name),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditImageScreen(selectedImage: file.url)));
      },
    );
  }
}
