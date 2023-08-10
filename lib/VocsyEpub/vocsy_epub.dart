import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class VocsyEpubReader extends StatelessWidget {
  const VocsyEpubReader({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Vocsy Epub Reader"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              _openEpub();
            },
            child: Text("Open")),
      ),
    );
  }

  Future<void> _openEpub() async {
    try {
      await VocsyEpub.openAsset(
        'assets/Essence_of_Bhagavad-gita.epub',
        lastLocation: EpubLocator.fromJson({
          "bookId": "2239",
          "href": "/OEBPS/ch06.xhtml",
          "created": 1539934158390,
          "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"},
        }
        ),
      );

      // Listen for the locator stream to save reading progress
      VocsyEpub.locatorStream.listen((locator) {
        print('LOCATOR: ${EpubLocator.fromJson(jsonDecode(locator))}');
        // Save the locator to your database for retrieval later
      });
    } catch (e) {
      print('Error opening EPUB: $e');
    }
  }
}
