import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:blog_parser/src/conversion_utilities/custom_components.dart';
import 'package:html/dom.dart' as dom;
import 'package:blog_parser/src/conversion_utilities/link_map.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class ConversionEngine {
  String classToRemove;
  bool stripEmptyElements = true;
  String domain;
  LinkMap linkMap = LinkMap();
  Uuid uuid = Uuid();

  TextBasedElement h1;
  TextBasedElement h2;
  TextBasedElement h3;
  TextBasedElement h4;
  TextBasedElement h5;
  TextBasedElement h6;
  TextBasedElement p;
  HRDivider hr;
  TextStyle defaultLinkStyle;

  Function customRender;

  ConversionEngine({
    this.classToRemove,
    this.customRender,
    this.domain,
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


  void linkInterpolation(dom.Element node) {
    List<dom.Element> els = node.getElementsByTagName('a');
    if (els != null && els.isNotEmpty) {
      els.forEach((link) {
        if (link.text != null && link.text.isNotEmpty && !link.text.contains(RegExp('\[FINDME_ID_{{(?<href>.*)}}_ENDID_\]'))) {
          String href = link.attributes['href'];
          if (href != null && href != '') {
            String id = uuid.v5(Uuid.NAMESPACE_URL, href);
            Uri uri = Uri.parse(href);
            if (uri.isAbsolute) {
              // does link go to outside source?
              if (!href.contains(domain)) {
                linkMap.links[id] = {
                  'href': href,
                  'type': 'external',
                };
                // print('extenal link: ${temp}');
              }
            } else {
              linkMap.links[id] = {
                  'href': href,
                  'type': 'general',
                };
            }
            // link.text = '[FINDME]${link.text}[/FINDME]';

            
            link.text = '[FINDME_ID_${id}_ENDID_]${link.text}[/FINDME]';
            // is link internal?
              // link.text = '[FINDME]${link.text}[/FINDME]';
            // if (href.contains(domain)) {
            //   print('link is internal: $href');
            // }

            // is the link internal?
            // int index = href.indexOf('#');
            // if (index >= 0) {
            //   String id = href.substring(index);
            //   print('link is internal: $id');
            // }
            // is link external?
            

            // print('href: ${link.attributes['href']}');
            // link.text = '[FINDME]${link.text}[/FINDME]';
          }
          
          // link.text = '[FINDME]${link.text}[/FINDME]';
        }
      });
    }
    // print('node.text: ${node.text}');
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

      //Check for ID's
      if (node.id != '') {
        // print('id: ${node.id}');
      }

      if (stripEmptyElements && (node.text == '\u00A0')) {
        return Container();
      }

      if (classToRemove != null && node.classes.contains(classToRemove)) {
        return Container();
      }

      switch (node.localName) {
        case H1:
          linkInterpolation(node);
          return h1.cloneWithText(node.text);

        case H2:
          linkInterpolation(node);
          return h2.cloneWithText(node.text);

        case H3:
          linkInterpolation(node);
          return h3.cloneWithText(node.text);

        case H4:
          linkInterpolation(node);
          return h4.cloneWithText(node.text);

        case H5:
          linkInterpolation(node);
          return h5.cloneWithText(node.text);

        case H6:
          linkInterpolation(node);
          return h6.cloneWithText(node.text);

        case P:
          linkInterpolation(node);
          return p.cloneWithText(node.text.replaceAll('\u00A0', ''));

        case HR:
          return HRDivider();

        default:
          return null;
      }
    }
  }
}
