import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:blog_parser/src/conversion_utilities/custom_components.dart';
import 'package:html/dom.dart' as dom;
import 'package:blog_parser/src/conversion_utilities/link_map.dart';
import 'package:blog_parser/src/conversion_utilities/id_map.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class ConversionEngine {
  String classToRemove;
  bool stripEmptyElements = true;
  String domain;
  LinkMap linkMap = LinkMap();
  IDMap idMap = IDMap();
  Uuid uuid = Uuid();
  BuildContext context;

  TextBasedElement h1;
  TextBasedElement h2;
  TextBasedElement h3;
  TextBasedElement h4;
  TextBasedElement h5;
  TextBasedElement h6;
  Paragraph2 p;
  HRDivider hr;
  TextStyle defaultLinkStyle;

  Function customRender;

  ConversionEngine({
    this.classToRemove,
    this.customRender,
    this.domain,
    this.context,
    TextBasedElement h1,
    TextBasedElement h2,
    TextBasedElement h3,
    TextBasedElement h4,
    TextBasedElement h5,
    TextBasedElement h6,
    Paragraph2 p,
  }) {
    this.h1 = h1 ?? Header(type: ElementType.h1);
    this.h2 = h2 ?? Header(type: ElementType.h2);
    this.h2 = h2 ?? Header(type: ElementType.h2);
    this.h3 = h3 ?? Header(type: ElementType.h3);
    this.h4 = h4 ?? Header(type: ElementType.h4);
    this.h5 = h5 ?? Header(type: ElementType.h5);
    this.h6 = h6 ?? Header(type: ElementType.h6);
    this.p = p ?? Paragraph2();
    this.hr = hr ?? HRDivider();
  }

  void setContext(BuildContext context) {
    context = context;
  }

  void getContext(BuildContext context) {
    print(context);
  }


  void linkInterpolation(dom.Element node) {
    List<dom.Element> els = node.getElementsByTagName('a');
    if (els != null && els.isNotEmpty) {
      els.forEach((link) {
        if (link.text != null && link.text.isNotEmpty && !link.text.contains(RegExp(r'\[FINDME_ID_(.*)_ENDID_\]'))) {
          // print(link.attributes);
          String href = (link.attributes.isNotEmpty ? link.attributes['href'] : null);
          if (href != null && href != '') {
            String id = uuid.v5(Uuid.NAMESPACE_URL, href);
            Uri uri = Uri.parse(href);
            // absolute links
            if (uri.isAbsolute) {
              // does link go to outside source?
              if (!href.contains(domain)) {
                linkMap.links[id] = {
                  'href': href,
                  'type': 'external',
                  'url_type': 'absolute',
                };
              } else {
                linkMap.links[id] = {
                  'href': href,
                  'type': 'internal',
                  'url_type': 'absolute',
                };
              }
            } else {
              //
              linkMap.links[id] = {
                  'href': href,
                  'type': 'internal',
                  'url_type': 'relative',
                };
            }

            linkMap.links[id]['to_id'] = uri.fragment;
            link.text = '[FINDME_ID_${id}_ENDID_]${link.text}[/FINDME]';
          }
        }
      });
    }
  }

  Widget copyWidgetWithText(dynamic inWidget, String text, [ String index ]){
    switch(inWidget.type) {
      case ElementType.p:
        return Paragraph2(
          padding: inWidget.padding,
          margin: inWidget.margin,
          color: inWidget.color,
          fontSize: inWidget.fontSize,
          text: text,
          index: index,
        );
      default:
        return Paragraph2(
          padding: inWidget.padding,
          margin: inWidget.margin,
          color: inWidget.color,
          fontSize: inWidget.fontSize,
          text: text,
          index: index,
        );
    }
  }

  Widget run(dom.Node node, List<Widget> children) {
    //Run customRender first if the user has defined it.
    if (customRender != null) {
      return customRender(node, children);
    }

    if (node is dom.Element) {
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
          // Key key;
          // key = containsId(node);
          // return h1.cloneWithText(node.text, key);
          // print(p.fontSize);
          // var {...p} = p;
          // print(p.)
          // Paragraph2 p2 = Paragraph2({...p});
          
          linkInterpolation(node);
          return copyWidgetWithText(p, node.text, node.id);

          // return p;
          // return ;
          // return Paragraph2()..;

        case H2:
          linkInterpolation(node);
          Key key;
          // key = containsId(node);
          return h2.cloneWithText(node.text, key);

        case H3:
          Key key;
          linkInterpolation(node);
          return h3.cloneWithText(node.text, key);

        case H4:
          Key key;
          linkInterpolation(node);
          return h4.cloneWithText(node.text, key);

        case H5:
          Key key;
          linkInterpolation(node);
          return h5.cloneWithText(node.text, key);

        case H6:
          Key key;
          linkInterpolation(node);
          return h6.cloneWithText(node.text, key);

        case P:
          // Key key;
          // linkInterpolation(node);
          // return p.cloneWithText(node.text.replaceAll('\u00A0', ''), key);
          return Text('paragraph text');

        case HR:
          return HRDivider();

        default:
          return null;
      }
    }
  }
}
