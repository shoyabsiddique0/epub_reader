import 'package:ebook_reader/EbookRead/ebook_read.dart';
import 'package:ebook_reader/EpubxReader/epubx_reader.dart';
import 'package:ebook_reader/VocsyEpub/vocsy_epub.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("EBook Reader"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EbookRead()));
                },
                child: Text("Epub View Package")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VocsyEpubReader()));
                },
                child: Text("Vocsy Epub View Package")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EpubWidget()));
                },
                child: Text("EpubX")),
          ],
        ),
      ),
    );
  }
}
