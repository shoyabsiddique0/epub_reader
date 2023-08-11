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
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
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
                              return SingleChildScrollView(
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    if (details.delta.dx > 0) {
                                      print("Go Back");
                                      print(controller.page!.toInt() - 1);
                                      controller.animateToPage(
                                          controller.page!.toInt() - 1,
                                          duration: Duration(milliseconds: 10),
                                          curve: Curves.bounceIn);
                                    } else if (details.delta.dx < 0) {
                                      print("Go Aage");
                                      print(controller.page!.toInt() + 1);
                                      controller.animateToPage(
                                          controller.page!.toInt() + 1,
                                          duration: Duration(milliseconds: 10),
                                          curve: Curves.bounceIn);
                                    }
                                  },
                                  child: SizedBox(
                                    // height: 400,
                                    width: MediaQuery.of(context).size.width,
                                    child: Html(
                                      data: snapshot1.hasData
                                          ? snapshot1.data
                                          : "",
                                      style: {
                                        "body": Style(
                                          fontSize: FontSize(dyanmicFont),
                                        ),
                                        "h1": Style(color: Colors.blue),
                                        "h2": Style(color: Colors.amber)
                                      },
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
}
