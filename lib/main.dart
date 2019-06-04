import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:blog_parser/src/conversion_utilities/conversion_engine.dart';
import 'package:blog_parser/src/conversion_utilities/custom_components.dart';

void main() {
  runApp(ArticleViewApp());
}

class ArticleViewApp extends StatefulWidget {
  _ArticleViewAppState createState() => _ArticleViewAppState();
}

class _ArticleViewAppState extends State<ArticleViewApp> {

  ScrollController controller = ScrollController();

  void _goToElement(double offset) {

    Duration duration = Duration(milliseconds: 100);
    controller.animateTo(offset, duration: duration, curve: Curves.easeOut);
  }
  
  ConversionEngine engine = ConversionEngine(
    classToRemove: 'hideme',
    domain: 'amchara.com',
    p: Paragraph2(
      color: Colors.red,
      fontSize: 50,
      padding: EdgeInsets.all(25),
      text: 'some text here',
    ),
    // customRender: (node, children) {
    //   if (node is dom.Element) {
    //     if (node.localName == 'h1') {
    //       return Text('tisk tisk tisk');
    //     }
    //   }
    // }
  );

  Widget filteredContent(BuildContext context, String rawString) {
    engine.setContext(context);

    return SingleChildScrollView(
      controller: controller,
      child: Html(
        data: rawString ?? '',
        useRichText: false,
        customRender: engine.run,
      ),
    );
  }

  Widget content(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/example-post.html'),
          builder: (context, snapshot) {
            return filteredContent(context, snapshot.data);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Article View App'),
        ),
        body: content(context),
      ),
    );
  }
}
