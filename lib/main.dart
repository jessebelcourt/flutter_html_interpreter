import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:html/dom.dart' as dom;

import 'package:blog_parser/src/conversion_utilities/conversion_engine.dart';

void main() {
  runApp(ArticleViewApp());
}

class ArticleViewApp extends StatefulWidget {
  _ArticleViewAppState createState() => _ArticleViewAppState();
}

class _ArticleViewAppState extends State<ArticleViewApp> {
  final ConversionEngine engine = ConversionEngine();

  Widget filteredContent(String rawString) {
    return SingleChildScrollView(
      child: Html(
        data: rawString ?? '',
        useRichText: false,
        customRender: engine.run,
      ),
    );
  }

  Widget content(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/example-post.txt'),
          builder: (context, snapshot) {
            return filteredContent(snapshot.data);
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
