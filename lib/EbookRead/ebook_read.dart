import 'package:ebook_reader/EbookRead/ebook_read_controller.dart';
import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EbookRead extends StatelessWidget {
  const EbookRead({super.key});

  @override
  Widget build(BuildContext context) {
    EbookReadController controller = Get.put(EbookReadController());
    return Scaffold(
      appBar: AppBar(
        title: EpubViewActualChapter(
          controller: controller.epubController,
          builder: (chapter) {
            return Text(
              'Chapter: ${chapter?.chapter?.Title?.replaceAll('\n', '').trim() ?? ''}',
              textAlign: TextAlign.start,
            );
          },
        ),
      ),
      drawer: Drawer(
          child:
              EpubViewTableOfContents(controller: controller.epubController)),
      body: EpubView(controller: controller.epubController, shrinkWrap: true),
    );
  }
}
