import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
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

  Widget myCustomRender(dom.Node element, List<Widget> children) {
    
    if (element is dom.Element) {
      switch(element.localName) {
        
        case ConversionEngine.h1: return Text(element.text);
        case ConversionEngine.h2: return H1(text: element.text);
        case 'h3': return Text(element.innerHtml);
        case 'h4': return Text(element.innerHtml);
        case 'h5': return Text(element.innerHtml);
        case 'h6': return Text(element.innerHtml);
        // case 'p': return Text(element.innerHtml);
        default:
          return null;
      }

    }
  }
  
  Widget filteredContent(String rawString) {
    return SingleChildScrollView(
      child: Html(
        data: rawString ?? '',
        useRichText: false,
        customRender: myCustomRender,
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
      // theme: ThemeData(
      //   textTheme: TextTheme(
      //     body1: TextStyle(
      //       color: Colors.purple,
      //     ),
      //     display1: TextStyle(
      //       color: Colors.red,
      //     ),
      //     display2: TextStyle(
      //       color: Colors.red,
      //     ),
      //     display3: TextStyle(
      //       color: Colors.red,
      //     ),
      //     display4: TextStyle(
      //       color: Colors.red,
      //     ),
      //   ),
      // ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Article View App'),
        ),
        body: content(context),
      ),
    );
  }
}
