import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class EpubWebView extends StatefulWidget {
  final Future<List<EpubChapterRef>> chapter;
  final String title;
  EpubWebView({super.key, required this.title, required this.chapter});

  @override
  State<EpubWebView> createState() => _EpubWebViewState();
}

class _EpubWebViewState extends State<EpubWebView> {
  double dyanmicFont = 15;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  dyanmicFont += 5;
                });
              },
              icon: Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: Icon(Icons.text_fields_rounded)),
          IconButton(
              onPressed: () {
                setState(() {
                  dyanmicFont -= 5;
                });
              },
              icon: Icon(Icons.minimize_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: widget.chapter.asStream(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? Column(
                      children: snapshot.data!.map((e) {
                        // String data = await e.readHtmlContent();
                        return FutureBuilder<String>(
                            future: e.readHtmlContent(),
                            builder: (context, snapshot1) {
                              return Html(
                                data: snapshot1.hasData ? snapshot1.data : "",
                                style: {
                                  "body": Style(
                                    fontSize: FontSize(dyanmicFont),
                                  ),
                                  "h1": Style(color: Colors.blue),
                                  "h2": Style(color: Colors.amber)
                                },
                              );
                            });
                      }).toList(),
                    )
                  : Text("Data");
            }),
      ),
    );
  }
}
