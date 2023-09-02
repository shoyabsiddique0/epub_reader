import 'dart:typed_data';

import 'package:ebook_reader/EpubxReader/epub_web_view.dart';
import 'package:ebook_reader/css_model.dart';
import 'package:ebook_reader/css_to_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:epubx/epubx.dart' as epub;
import 'package:image/image.dart' as image;

void main() => runApp(EpubWidget());

class EpubWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EpubState();
}

class EpubState extends State<EpubWidget> {
  Future<epub.EpubBookRef>? book;

  final _urlController = TextEditingController();

  void fetchBookButton() {
    setState(() {
      book = fetchBook(_urlController.text);
    });
  }

  void fetchBookPresets(String link) {
    setState(() {
      book = fetchBook(link);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fetch Epub Example",
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Material(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 16.0)),
                const Text(
                  'Epub Inspector',
                  style: TextStyle(fontSize: 25.0),
                ),
                const Padding(padding: EdgeInsets.only(top: 50.0)),
                const Text(
                  'Enter the Url of an Epub to view some of it\'s metadata.',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.only(top: 20.0)),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Enter Url",
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val!.length == 0) {
                      return "Url cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  style: const TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                ElevatedButton(
                  onPressed: fetchBookButton,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(8.0)),
                    textStyle:
                        MaterialStateProperty.all<TextStyle>(const TextStyle(
                      color: Colors.white,
                    )),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  child: const Text("Inspect Book"),
                ),
                const Padding(padding: EdgeInsets.only(top: 25.0)),
                const Text(
                  'Or select available links:',
                  style: TextStyle(fontSize: 18.0),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.only(top: 12.0)),
                Column(
                  children: [
                    ...[
                      'https://filesamples.com/samples/ebook/epub/Around%20the%20World%20in%2028%20Languages.epub',
                      'https://filesamples.com/samples/ebook/epub/Sway.epub',
                      'https://filesamples.com/samples/ebook/epub/Alices%20Adventures%20in%20Wonderland.epub',
                      'https://www.purebhakti.com/resources/ebooks-magazines/other/epubs/577-essence-of-bhagavad-gita-epub/file',
                      "https://cloudflare-ipfs.com/ipfs/bafykbzacecprokw3tm3tl6gduh3g3ph6542dywgkkqqsisv4rnckhbf7hqskw?filename=Ashwin%20Sanghi%20-%20Chanakya%E2%80%99s%20Chant%20%28Hindi%29-Westland%20%282014%29.epub",
                      "https://github.com/shoyabsiddique0/epub_reader/raw/main/hindi_sample.epub",
                      "https://github.com/shoyabsiddique0/ott_platform/raw/main/yathartha_geeta_epub.epub",
                      'https://cloudflare-ipfs.com/ipfs/bafykbzacecoyxtsxcmjah5jzbyddu5eot63ogkskxhc4zp4amwoitvasqi6kc?filename=Leach%2C%20Frann%20-%20Natural%20Colors%20to%20Dye%20for_%20How%20to%20Use%20Natural%20Dyes%20From%20Plants%20and%20Fungi-Free-EasyPublications%20com%20%282013%29.epub'
                    ]
                        .map((link) => TextButton(
                              child: Text(link),
                              onPressed: () => fetchBookPresets(link),
                            ))
                        .cast<Widget>()
                        .toList(),
                  ],
                ),
                const Padding(padding: EdgeInsets.only(top: 25.0)),
                Center(
                  child: FutureBuilder<epub.EpubBookRef>(
                    future: book,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Material(
                          color: Colors.white,
                          child: buildEpubWidget(snapshot.data!, context),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // By default, show a loading spinner
                      // return CircularProgressIndicator();

                      // By default, show just empty.
                      return Container();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildEpubWidget(epub.EpubBookRef book, context) {
  var chapters = book.getChapters();
  var cover = book.readCover();
  var css = book.Content!.Css;
  CssToStyle obj = CssToStyle();
  var data = obj.processData(css!);
  var styleSheet;

  return FutureBuilder(
      future: data,
      // initialData: InitialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          // styleSheet = obj.parseCSSString(snapshot.data);
          // Map<String, CssModel> data = CssModel().mapCssToModel(styleSheet);
          // Map<String, Style> parsedStyle = CssModel().mapToStyle(data);
          return Container(
              child: Column(
            children: <Widget>[
              const Text(
                "Title",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                book.Title!,
                style: const TextStyle(fontSize: 15.0),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              const Text(
                "Author",
                style: TextStyle(fontSize: 20.0),
              ),
              Text(
                book.Author!,
                style: const TextStyle(fontSize: 15.0),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(EpubWebView(
                        chapter: chapters,
                        title: book.Title!,
                        book: book,
                        style: snapshot.data));
                  },
                  child: const Text("See Book")),
              FutureBuilder<List<epub.EpubChapterRef>>(
                  future: chapters,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          const Text("Chapters",
                              style: TextStyle(fontSize: 20.0)),
                          Text(
                            snapshot.data!.length.toString(),
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container();
                  }),
              const Padding(
                padding: EdgeInsets.only(top: 15.0),
              ),
              FutureBuilder<epub.Image?>(
                future: cover,
                builder: (context, AsyncSnapshot<epub.Image?> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        const Text("Cover", style: TextStyle(fontSize: 20.0)),
                        Image.memory(Uint8List.fromList(
                            image.encodePng(snapshot.data!))),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }
                  return Container();
                },
              ),
              Column(
                children: book.Content!.Css!.entries
                    .map((value) => FutureBuilder<String>(
                        future: value.value.ReadContentAsync(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? Text(
                                  snapshot.data!,
                                  style: TextStyle(color: Colors.black),
                                )
                              : const Text("");
                        }))
                    .toList(),
              ),
            ],
          ));
        }
        return Text("");
      }
      // return Text("");
      );
  print(styleSheet);
  return Text("");
}

// Needs a url to a valid url to an epub such as
// https://www.gutenberg.org/ebooks/11.epub.images
// or
// https://www.gutenberg.org/ebooks/19002.epub.images
Future<epub.EpubBookRef> fetchBook(String url) async {
  // Hard coded to Alice Adventures In Wonderland in Project Gutenberb
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the EPUB
    return epub.EpubReader.openBook(response.bodyBytes);
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load epub');
  }
}
