import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/conversion_engine.dart';

void main() {
  runApp(ArticleViewApp());
}

class ArticleViewApp extends StatefulWidget {
  _ArticleViewAppState createState() => _ArticleViewAppState();
}

class _ArticleViewAppState extends State<ArticleViewApp> {

  Widget filteredContent(BuildContext context, String rawString) {
    return RenderHtml(text: rawString);
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
