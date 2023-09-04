import 'dart:typed_data';
import 'package:epubx/src/ref_entities/epub_byte_content_file_ref.dart';
import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter/widgets.dart' as widgets;
import 'package:html/parser.dart';

class EpubWebView extends StatefulWidget {
  final Future<List<EpubChapterRef>> chapter;
  final String title;
  final EpubBookRef book;
  final String style;
  const EpubWebView(
      {super.key,
      required this.title,
      required this.chapter,
      required this.book,
      required this.style});

  @override
  State<EpubWebView> createState() => _EpubWebViewState();
}

class _EpubWebViewState extends State<EpubWebView> {
  double dyanmicFont = 15.sp;
  PageController controller = PageController();
  PageController controller1 = PageController();
  double panDetails = 0;
  @override
  Widget build(BuildContext context) {
    var css = widget.book.Content?.Css;
    var cover = widget.book.readCover();
    return Scaffold(
      drawer: Drawer(
        child: FutureBuilder(
            future: widget.chapter,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                          title: Text(snapshot.data![index].Title.toString()),
                          onTap: () => controller.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.bounceIn),
                          subtitle: Column(
                            children: snapshot.data![index].SubChapters!
                                .map((e) => ListTile(
                                      title: Text(e.Title.toString()),
                                    ))
                                .toList(),
                          ));
                    });
              }
              return const Text("");
            }),
      ),
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  dyanmicFont += 5.sp;
                });
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.text_fields_rounded)),
          IconButton(
              onPressed: () {
                setState(() {
                  dyanmicFont -= 5.sp;
                });
              },
              icon: const Icon(Icons.minimize_outlined)),
        ],
      ),
      body: StreamBuilder(
          stream: widget.chapter.asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data!;
              var imagesList = widget.book.Content!.Images;
              return snapshot.hasData
                  ? PageView(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      controller: controller,
                      // itemCount: data.length,
                      children: data.map((e) {
                        return FutureBuilder<String>(
                            future: e.readHtmlContent(),
                            builder: (context, snapshot1) {
                              return SingleChildScrollView(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    setState(() {
                                      panDetails = details.delta.dx;
                                    });
                                  },
                                  onPanEnd: (details) {
                                    int length = splitString(
                                            500.w,
                                            600.h,
                                            dyanmicFont.toInt(),
                                            snapshot1.hasData
                                                ? snapshot1.data!
                                                : "")
                                        .length;
                                    if (panDetails > 0) {
                                      if (controller1.page == 0 &&
                                          controller.page != 0) {
                                        controller.animateToPage(
                                            controller.page!.toInt() - 1,
                                            duration: const Duration(
                                                milliseconds: 10),
                                            curve: Curves.bounceIn);
                                        controller1.animateToPage(length - 1,
                                            duration: const Duration(
                                                milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      } else {
                                        controller1.animateToPage(
                                            controller1.page!.toInt() - 1,
                                            duration: const Duration(
                                                milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      }
                                    } else if (panDetails < 0) {
                                      if (controller1.page == length - 1) {
                                        controller.animateToPage(
                                            controller.page!.toInt() + 1,
                                            duration: const Duration(
                                                milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      } else {
                                        controller1.animateToPage(
                                            controller1.page!.toInt() + 1,
                                            duration: const Duration(
                                                milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      height: 600.h,
                                      width: 300.w,
                                      child: PageView.builder(
                                          controller: controller1,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: splitString(
                                                  300.w,
                                                  600.h,
                                                  dyanmicFont.toInt(),
                                                  snapshot1.hasData
                                                      ? snapshot1.data!
                                                      : "")
                                              .length,
                                          itemBuilder: (context, index) {
                                            List data = splitString(
                                                300,
                                                600,
                                                dyanmicFont.toInt(),
                                                snapshot1.hasData
                                                    ? snapshot1.data!
                                                    : "");
                                            // print(data);
                                            return HtmlWidget(
                                              '''
                                                <html>
                                                <head></head>
                                                <style>${widget.style}</style>
                                                <body>
                                                ${data[index]}
                                                </body>
                                                </html>
                                              ''',
                                              customWidgetBuilder: (element) {
                                                EpubByteContentFileRef?
                                                    imageData;
                                                if (element.localName ==
                                                    "img") {
                                                  print(element.innerHtml);
                                                  for (var i in element
                                                      .attributes.entries) {
                                                    print(i);
                                                    if (i.key == "src") {
                                                      // print(value[
                                                      //     value.length - 1]);
                                                      for (var e in imagesList!
                                                          .entries) {
                                                        if (e.key == i.value) {
                                                          print(e);
                                                          imageData = e.value;
                                                        }
                                                      }
                                                    }
                                                  }
                                                  return FutureBuilder(
                                                      future: imageData!
                                                          .readContentAsBytes(),
                                                      builder:
                                                          (context, snapshot) {
                                                        return snapshot.hasData
                                                            ? widgets.Image
                                                                .memory(Uint8List
                                                                    .fromList(
                                                                        snapshot
                                                                            .data!))
                                                            : const SizedBox
                                                                .shrink();
                                                      });
                                                }
                                              },
                                              // shrinkWrap: true,
                                              // style: widget.style,
                                              // style: {
                                              //   "*": Style(
                                              //     fontSize:
                                              //         FontSize(dyanmicFont),
                                              //   ),
                                              // "h1": Style(
                                              //     color: Colors.blue,
                                              //     fontSize:
                                              //         FontSize(dyanmicFont)),
                                              // "h2": Style(
                                              //     color: Colors.amber,
                                              //     fontSize:
                                              //         FontSize(dyanmicFont))
                                              // },
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }).toList())
                  : const Text("Data");
            }
            return const Text("");
          }),
    );
  }

  List<String> splitString(
      double width, double height, int fontSize, String text) {
    int maxCharacters;
    List<String> listData = [];
    if (width > 0 && height > 0 && fontSize > 0) {
      double maxWidthPerLine = width / fontSize;
      double maxHeight = height / fontSize;
      String tag = "";
      String data = "";
      var document = parse(text);
      // print("--->${document.body!.nodes}");
      maxCharacters = (maxWidthPerLine * maxHeight).floor();
      listData = splitHtmlWithTags(text, maxCharacters);
      // for (var i in document.body!.nodes) {
      //   if (i.hasChildNodes()) {
      //     for (var j in i.nodes) {
      //       // print("---->$j");
      //     }
      //   }
      // }
      //     for (int i = 0, j = 1; i <= text.length; j++) {
      //       if (i + maxCharacters > text.length) {
      //         data = text.substring(i, text.length).trim();
      //         listData.add(data);
      //         i += maxCharacters;
      //       } else {
      //         int index = text.substring(i, i + maxCharacters).lastIndexOf(" ");
      //         data = text.substring(i, i + index).trim();
      //         listData.add(data.trim());
      //         i += index;
      //       }
      //     }
      //   } else {
      //     maxCharacters = 0;
      //   }
      //   print(listData.length);
    }
    return listData;
  }

  List<String> splitHtmlWithTags(String html, int maxCharacters) {
    List<String> chunks = [];
    String currentChunk = '';

    final dom.Document document = parse(html);
    final dom.NodeList nodes = document.body!.nodes;

    for (var node in nodes) {
      String nodeHtml = "";
      if (node is dom.Element) {
        nodeHtml = node.outerHtml;
      }

      while (nodeHtml.isNotEmpty) {
        int endIndex = nodeHtml.length;
        if (endIndex > maxCharacters) {
          endIndex = nodeHtml.lastIndexOf(' ', maxCharacters);
          if (endIndex == -1) {
            endIndex = maxCharacters;
          }
        }

        String chunkPart = nodeHtml.substring(0, endIndex);
        currentChunk += chunkPart;
        nodeHtml = nodeHtml.substring(endIndex);

        if (currentChunk.trim().isNotEmpty) {
          chunks.add(currentChunk);
          currentChunk = '';
        }
      }
    }
    // print(chunks);
    return chunks;
  }
}
