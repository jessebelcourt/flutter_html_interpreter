import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:html/dom.dart' as dom;

class TextElement extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final ElementType type;
  double fontSize;
  String text;

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
    this.text = '',
    this.type = ElementType.p,
    fontSize
  }) {
    // set font size
    this.fontSize = fontSize ?? fontSizes[type];
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: padding,
          margin: margin,
          child: Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: fontSize,
            ),
          ),
        )
      ],
    );
  }

  Widget p() {
    return Container(
      padding: padding,
      margin: EdgeInsets.all(0),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget element;
    if (headers.contains(type)) {
      element = header();
    } else {
      element = p();
    }

    return element;
  }
}

class ConversionEngine {
  String classToRemove;
  TextElement h1;
  TextElement h2;
  TextElement h3;
  TextElement h4;
  TextElement h5;
  TextElement h6;
  TextElement p;

  ConversionEngine({this.classToRemove, h1}) {
    this.h1 = h1 ?? TextElement(type: ElementType.h1);
    this.h2 = h2 ?? TextElement(type: ElementType.h2);
    this.h2 = h2 ?? TextElement(type: ElementType.h2);
    this.h3 = h3 ?? TextElement(type: ElementType.h3);
    this.h4 = h4 ?? TextElement(type: ElementType.h4);
    this.h5 = h5 ?? TextElement(type: ElementType.h5);
    this.h6 = h6 ?? TextElement(type: ElementType.h6);
    this.p = p ?? TextElement(type: ElementType.p);
  }

  Widget run(dom.Node node, List<Widget> children) {
    if (node is dom.Element) {
      if (classToRemove != null && node.classes.contains(classToRemove)) {
        return Container();
      }

      switch (node.localName) {
        case H1:
          h1.text = node.text;
          return h1;

        case H2:
          h2.text = node.text;
          return h2;

        case H3:
          h3.text = node.text;
          return h3;

        case H4:
          h4.text = node.text;
          return h4;

        case H5:
          h5.text = node.text;
          return h5;

        case H6:
          h6.text = node.text;
          return h6;

        case P:
          print(node.text == '\u00A0');

          


          if (node.text == '\u00A0') {
            return null;
          }

          node.text = node.text.replaceAll('\u00A0', '');
          p.text = node.text;
          return p;

        default:
          return null;
      }
    }
  }
}
