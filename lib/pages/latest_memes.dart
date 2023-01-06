import 'dart:convert';
import 'dart:developer';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class TrendingMeme {
  final String title;
  final String url;

  const TrendingMeme({required this.title, required this.url});

  factory TrendingMeme.fromJson(Map<String, dynamic> json) {
    return TrendingMeme(
      title: json['title'],
      url: json['url'],
    );
  }
}

Future<List<TrendingMeme>> getTrending() async {
  // final response = await http
  //     .get(Uri.parse("https://reddit-meme.p.rapidapi.com/memes/top"), headers: {
  //   'X-RapidAPI-Key': '13e8077673msh0e9aad84ff1cdb1p1c9a44jsne379ff254628',
  //   'X-RapidAPI-Host': 'reddit-meme.p.rapidapi.com'
  // });
  // List<dynamic> data = jsonDecode(response.body);

  final String response = await rootBundle.loadString('assets/trending.json');
  await Future.delayed(Duration(milliseconds: 2000));

  List<dynamic> data = jsonDecode(response);
  List<TrendingMeme> results = [];

  for (var i = 0; i < data.length; i++) {
    final entry = data[i];
    results.add(
      TrendingMeme.fromJson(entry),
    );
  }
  return results;
}

class LatestMemes extends StatefulWidget {
  const LatestMemes({super.key});

  @override
  State<LatestMemes> createState() => _LatestMemesState();
}

class _LatestMemesState extends State<LatestMemes> {
  late Future<List<TrendingMeme>> memes;

  @override
  void initState() {
    super.initState();
    memes = getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 550,
              child: FutureBuilder(
                  future: memes,
                  builder: (context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      return Swiper(
                          scale: 0.8,
                          itemCount: snapshot.data!.length,
                          pagination: SwiperPagination(),
                          itemBuilder: (context, int index) {
                            TrendingMeme item = snapshot.data[index];
                            return Card(
                              elevation: 2,
                              child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Text(
                                        item.title,
                                        style: TextStyle(
                                            color: Colors.cyan,
                                            fontSize: 29,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 20),
                                      Image.network(item.url),
                                    ],
                                  )),
                            );
                          });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

/*

*/
