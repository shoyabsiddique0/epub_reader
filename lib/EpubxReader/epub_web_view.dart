import 'package:epubx/epubx.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class EpubWebView extends StatefulWidget {
  final Future<List<EpubChapterRef>> chapter;
  final String title;
  final EpubBookRef book;
  EpubWebView(
      {super.key,
      required this.title,
      required this.chapter,
      required this.book});

  @override
  State<EpubWebView> createState() => _EpubWebViewState();
}

class _EpubWebViewState extends State<EpubWebView> {
  double dyanmicFont = 15;
  PageController controller = PageController();
  PageController controller1 = PageController();
  double panDetails = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.book.Schema?.Navigation?.NavMap?.Points);
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
                              duration: Duration(milliseconds: 300),
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
              return Text("");
            }),
      ),
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
      body: StreamBuilder(
          stream: widget.chapter.asStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List data = snapshot.data!;
              return snapshot.hasData
                  ? PageView(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      controller: controller,
                      // itemCount: data.length,
                      children: data.map((e) {
                        return FutureBuilder<String>(
                            future: e.readHtmlContent(),
                            builder: (context, snapshot1) {
                              // print(snapshot1.data);
                              return SingleChildScrollView(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    print(details.delta.dx);
                                    setState(() {
                                      panDetails = details.delta.dx;
                                    });
                                  },
                                  onPanEnd: (details) {
                                    int length = splitString(
                                            500,
                                            600,
                                            dyanmicFont.toInt(),
                                            snapshot1.hasData
                                                ? snapshot1.data!
                                                : "")
                                        .length;
                                    if (panDetails > 0) {
                                      print("Go Back");
                                      if (controller1.page == 0 &&
                                          controller.page != 0) {
                                        print(controller.page!.toInt() - 1);
                                        controller.animateToPage(
                                            controller.page!.toInt() - 1,
                                            duration:
                                                Duration(milliseconds: 10),
                                            curve: Curves.bounceIn);
                                        controller1.animateToPage(length - 1,
                                            duration:
                                                Duration(milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      } else {
                                        controller1.animateToPage(
                                            controller1.page!.toInt() - 1,
                                            duration:
                                                Duration(milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      }
                                    } else if (panDetails < 0) {
                                      print("Go Aage");
                                      if (controller1.page == length - 1) {
                                        print(controller.page!.toInt() + 1);
                                        controller.animateToPage(
                                            controller.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      } else {
                                        controller1.animateToPage(
                                            controller1.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 10),
                                            curve: Curves.bounceIn);
                                      }
                                    }
                                  },
                                  child: Center(
                                    child: SizedBox(
                                      height: 600,
                                      width: 300,
                                      child: PageView.builder(
                                          controller: controller1,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          scrollDirection: Axis.horizontal,
                                          itemCount: splitString(
                                                  500,
                                                  600,
                                                  dyanmicFont.toInt(),
                                                  snapshot1.hasData
                                                      ? snapshot1.data!
                                                      : "")
                                              .length,
                                          itemBuilder: (context, index) {
                                            List data = splitString(
                                                500,
                                                600,
                                                dyanmicFont.toInt(),
                                                snapshot1.hasData
                                                    ? snapshot1.data!
                                                    : "");
                                            return Html(
                                              data: data[index],
                                              style: {
                                                "body": Style(
                                                  fontSize:
                                                      FontSize(dyanmicFont),
                                                ),
                                                "h1": Style(color: Colors.blue),
                                                "h2": Style(color: Colors.amber)
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              );
                            });
                      }).toList())
                  : Text("Data");
            }
            return Text("");
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
      maxCharacters = (maxWidthPerLine * maxHeight).floor();
      for (int i = 0; i <= text.length;) {
        if (i + maxCharacters > text.length) {
          listData.add(text.substring(i, text.length));
          i += maxCharacters;
        } else {
          int index = text.substring(i, i + maxCharacters).lastIndexOf(" ");
          listData.add(text.substring(i, i + index));
          i += index;
        }
      }
    } else {
      maxCharacters = 0;
    }
    // print(listData);
    return listData;
  }
}
