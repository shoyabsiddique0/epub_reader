import 'package:ebook_reader/CustomReader/custom_reader_screen.dart';
import 'package:ebook_reader/EbookRead/ebook_read.dart';
import 'package:ebook_reader/EpubxReader/epubx_reader.dart';
import 'package:ebook_reader/VocsyEpub/vocsy_epub.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EBook Reader"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EbookRead()));
                },
                child: const Text("Epub View Package")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VocsyEpubReader()));
                },
                child: const Text("Vocsy Epub View Package")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EpubWidget()));
                },
                child: const Text("EpubX")),
            ElevatedButton(
                onPressed: () {
                  Get.to(const CustomReaderScreen());
                },
                child: const Text("Custom Reader")),
            // ElevatedButton(
            //     onPressed: () {
            //       Get.to(const EpubKittyView());
            //     },
            //     child: const Text("Kitty Reader")),
          ],
        ),
      ),
    );
  }
}
