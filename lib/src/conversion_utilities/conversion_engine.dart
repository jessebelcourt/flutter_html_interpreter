import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:blog_parser/src/conversion_utilities/custom_components.dart';
import 'package:html/dom.dart' as dom;

typedef Text customRenderType(dynamic node, dynamic children);

class ElementOptions {
  EdgeInsets padding;
  ElementOptions({this.padding});
}

class TextElement extends StatelessWidget {
  EdgeInsets padding;
  EdgeInsets margin;
  Color color;
  ElementType type;
  double fontSize;
  List<TextSpan> text;
  Key key;
  ElementOptions options;

  static List<ElementType> headers = [
    ElementType.h1,
    ElementType.h2,
    ElementType.h3,
    ElementType.h4,
    ElementType.h5,
    ElementType.h6,
  ];

  static Map<ElementType, double> fontSizes = {
    ElementType.h1: H1_FONT_SIZE,
    ElementType.h2: H2_FONT_SIZE,
    ElementType.h3: H3_FONT_SIZE,
    ElementType.h4: H4_FONT_SIZE,
    ElementType.h5: H5_FONT_SIZE,
    ElementType.h6: H6_FONT_SIZE,
    ElementType.p: P_FONT_SIZE,
  };

  TextElement({
    this.padding = defaultPadding,
    this.margin = defaultMargin,
    this.color = defaultHeaderColor,
    this.text = defaultText,
    this.type = ElementType.p,
    fontSize,
    this.options,
  }) {
    if (options != null) {}

    // set font size
    this.fontSize = fontSize ?? fontSizes[type];
  }

  List<TextSpan> buildContent(String text, int index) {
    List<TextSpan> content = [];
    const String FINDME = '[FINDME]';
    const String FINDME_END = '[/FINDME]';
    String temp = text;
    List<TextSpan> result = [];
    int indexStart;
    int indexEnd;

    //replace with link
    if (index >= 0) {
      while (temp.isNotEmpty) {
        indexStart = temp.indexOf(FINDME);
        indexEnd = temp.indexOf(FINDME_END);

        if (indexStart > -1 && indexEnd > -1) {
          if (indexStart == 0) {
            // adding link
            TextSpan input = TextSpan(
              text: temp.substring(FINDME.length, indexEnd),
              recognizer: TapGestureRecognizer()
                ..onTap = () => print('Tapped me'),
              style: TextStyle(
                color: Colors.red,
              ),
            );
            result.add(input);
            temp = temp.substring(indexEnd + FINDME_END.length);
          } else if (indexStart > 0) {
            // Not a link
            TextSpan input = TextSpan(
              text: temp.substring(0, indexStart),
              style: TextStyle(color: Colors.black),
            );
            result.add(input);
            temp = temp.substring(indexStart);
          } else if (temp.isNotEmpty) {
            TextSpan input = TextSpan(
              text: temp,
              style: TextStyle(color: Colors.black),
            );
            result.add(input);
            temp = '';
          }
        } else if (temp.isNotEmpty) {
          TextSpan input = TextSpan(
            text: temp,
            style: TextStyle(color: Colors.black),
          );
          result.add(input);
          temp = '';
        }
      }
    }
    return result;
  }

  Widget cloneWithText(String textIn) {
    int index = textIn.indexOf('[FINDME]');

    List<TextSpan> content = (index > -1
        ? buildContent(textIn, index)
        : <TextSpan>[TextSpan(text: textIn)]);

    return TextElement(
      padding: padding,
      margin: margin,
      type: type,
      fontSize: fontSize,
      text: content,
    );
  }

  Widget withKey(TextElement me, String id) {
    me.key = UniqueKey();
    return me;
  }
  
  Widget p() {
    return Container(
      padding: padding,
      margin: margin,
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: text.toList(),
        ),
      ),

      // child: Text(
      //   text,
      //   style: TextStyle(
      //     color: color,
      //     fontSize: fontSize,
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget element;
    if (headers.contains(type)) {
      element = Header(
        padding: padding,
        margin: margin,
        fontSize: fontSize,
        text: text.toList(),
      );
    } else {
      element = p();
    }

    return element;
  }
}

class ConversionEngine {
  String classToRemove;
  bool stripEmptyElements = true;
  String domain = 'amchara.com';

  ElementOptions h1Options;

  TextElement h1;
  TextElement h2;
  TextElement h3;
  TextElement h4;
  TextElement h5;
  TextElement h6;
  TextElement p;
  HRDivider hr;
  Function customRender;

  ConversionEngine({
    this.classToRemove,
    this.customRender,
    h1Options,
  }) {
    print(h1Options.runtimeType == ElementOptions);
    this.h1 = h1 ?? TextElement(type: ElementType.h1);
    this.h2 = h2 ?? TextElement(type: ElementType.h2);
    this.h2 = h2 ?? TextElement(type: ElementType.h2);
    this.h3 = h3 ?? TextElement(type: ElementType.h3);
    this.h4 = h4 ?? TextElement(type: ElementType.h4);
    this.h5 = h5 ?? TextElement(type: ElementType.h5);
    this.h6 = h6 ?? TextElement(type: ElementType.h6);
    this.p = p ??
        TextElement(
          type: ElementType.p,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          padding: EdgeInsets.only(top: 5, bottom: 5),
        );
    this.hr = hr ?? HRDivider();
  }

  void containsInternalLink(List<dom.Element> elements) {
    elements.forEach((el) {
      if (el.attributes['href'] != null) {
        // Uri uri = Uri.parse(el.attributes['href']);
        // String path = uri.path;
        int index = el.attributes['href'].indexOf('#');
        if (index >= 0) {
          String id = el.attributes['href'].substring(index);
          // print(id);
        }
        // print('index: $index');
      }
      // if (el.attributes['href'] != null && el.attributes['href'].contains(domain)) {
      //   Uri uri = Uri.parse(el.attributes['href']);
      //   String path = uri.path;
      //   print('path: $path');
      // }
    });
  }

  // bool checkForPadding() {

  // }

  void linkInterpolation(dom.Element node) {
    // List<dom.Element> els = node.children;
    // dom.Node newParent = node.clone(true);
    // node.parentNode.remove();
    // newParent.reparentChildren(null);
    // print(newParent);
    // dom.Element newParent = dom.Element.html(node.localName);
    // node.reparentChildren(newParent);

    // node.reparentChildren(newParent);
    // print(newParent.text);
    // dom.Element newParent = dom.Element();
    // List<dom.Element> broken = node.children
    // print(node.outerHtml);
    // node.children.forEach((el) {
    //   node.remove();
    // print('localtype: ${el.localName}');
    // print('nodeType: ${el.nodeType}');
    // print('el.text: ${el.text}');
    // });
    // node.children.forEach((el) => el.remove());
    // print(node.text);
    // node.children.forEach((el) {
    // print('el.text: ${el.text}');
    // print(el.nodeType == dom.Node.TEXT_NODE);
    // });
    node.getElementsByTagName('a').forEach((link) {
      if (!link.text.contains('[FINDME]')) {
        link.text = '[FINDME]${link.text}[/FINDME]';
      }
    });
    // print(node.text);
  }

  Widget run(dom.Node node, List<Widget> children) {
    //Run customRender first if the user has defined it.
    if (customRender != null) {
      return customRender(node, children);
    }

    if (node is dom.Element) {
      // List<dom.Element> els = node.getElementsByTagName('a');
      // containsInternalLink(els);
      var image = node.querySelector('img');
      if (image != null) {
        return null;
      }

      if (stripEmptyElements && (node.text == '\u00A0')) {
        return Container();
      }

      if (classToRemove != null && node.classes.contains(classToRemove)) {
        return Container();
      }

      return null;

      switch (node.localName) {
        case H1:
          // TextElement clone = h1.cloneWithText(node.text);
          // Key key  = clone.key;
          linkInterpolation(node);
          // node.replaceWith(node.clone(false));
          // return h1.cloneWithText('yooooooo');
          return h1.cloneWithText(node.text);
          break;

        case H2:
          return h2.cloneWithText(node.text);

        case H3:
          return h3.cloneWithText(node.text);

        case H4:
          // linkInterpolation(node);
          // print('node.localName: ${node.localName}');
          return h4.cloneWithText(node.text);

        case H5:
          return h5.cloneWithText(node.text);

        case H6:
          return h6.cloneWithText(node.text);

        case P:
          return p.cloneWithText(node.text.replaceAll('\u00A0', ''));

        case HR:
          return HRDivider();

        default:
          return null;
      }
    }
  }
}
