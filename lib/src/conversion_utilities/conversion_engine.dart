import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:blog_parser/src/conversion_utilities/custom_components.dart';
import 'package:html/dom.dart' as dom;

class ConversionEngine {
  String classToRemove;
  bool stripEmptyElements = true;
  String domain = 'amchara.com';

  TextBasedElement h1;
  TextBasedElement h2;
  TextBasedElement h3;
  TextBasedElement h4;
  TextBasedElement h5;
  TextBasedElement h6;
  TextBasedElement p;
  HRDivider hr;

  Function customRender;

  ConversionEngine({
    this.classToRemove,
    this.customRender,
    TextBasedElement h1,
    TextBasedElement h2,
    TextBasedElement h3,
    TextBasedElement h4,
    TextBasedElement h5,
    TextBasedElement h6,
    TextBasedElement p,
  }) {
    this.h1 = h1 ?? Header(type: ElementType.h1);
    this.h2 = h2 ?? Header(type: ElementType.h2);
    this.h2 = h2 ?? Header(type: ElementType.h2);
    this.h3 = h3 ?? Header(type: ElementType.h3);
    this.h4 = h4 ?? Header(type: ElementType.h4);
    this.h5 = h5 ?? Header(type: ElementType.h5);
    this.h6 = h6 ?? Header(type: ElementType.h6);
    this.p = p ?? Paragraph(type: ElementType.p);
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

  void linkInterpolation(dom.Element node) {
    node.getElementsByTagName('a').forEach((link) {
      if (!link.text.contains('[FINDME]')) {
        link.text = '[FINDME]${link.text}[/FINDME]';
      }
    });
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
