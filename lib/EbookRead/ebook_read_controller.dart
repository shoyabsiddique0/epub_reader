import 'package:epub_view/epub_view.dart';
import 'package:get/get.dart';

class EbookReadController extends GetxController {
  late EpubController epubController;
  @override
  void onInit() {
    epubController = EpubController(
      document: EpubDocument.openAsset("assets/Essence_of_Bhagavad-gita.epub"),
    );
    super.onInit();
  }
}
