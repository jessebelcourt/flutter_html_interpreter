import 'package:flutter/material.dart';
import 'package:html_interpreter/src/conversion_utilities/element_type.dart';
import 'package:html_interpreter/src/conversion_utilities/style_values.dart';
import 'package:html_interpreter/src/conversion_utilities/custom_components.dart';
import 'package:html/dom.dart' as dom;
import 'package:flutter_html/flutter_html.dart';
import 'package:html_interpreter/src/conversion_utilities/link_map.dart';
import 'package:html_interpreter/src/conversion_utilities/id_map.dart';
import 'package:html_interpreter/src/conversion_utilities/bus.dart';
import 'package:uuid/uuid.dart';

class RenderHtml extends StatefulWidget {
  final String text;
  RenderHtml({this.text});

  _RenderHtmlState createState() => _RenderHtmlState();
}

class _RenderHtmlState extends State<RenderHtml> {
  Bus bus = Bus();
  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    bus.screenPosition.stream.listen((offset) {
      _goToElement(offset);
    });
  }

  void _goToElement(double offset) {
    Duration duration = Duration(milliseconds: 100);
    controller.animateTo(offset, duration: duration, curve: Curves.easeOut);
  }
  
  ConversionEngine engine = ConversionEngine(
    classToRemove: 'hideme',
    domain: 'amchara.com',
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller,
      child: Html(
        data: widget.text ?? '',
        useRichText: false,
        customRender: engine.run,
      ),
    );
  }
}

class ConversionEngine {
  String classToRemove;
  bool stripEmptyElements = true;
  String domain;
  LinkMap linkMap = LinkMap();
  IDMap idMap = IDMap();
  Uuid uuid = Uuid();
  BuildContext context;
  bool samePageLinking = false;
  bool disableLinks = false;

  Header h1;
  Header h2;
  Header h3;
  Header h4;
  Header h5;
  Header h6;
  Paragraph p;
  HRDivider hr;
  TextStyle defaultLinkStyle;

  Function customRender;

  ConversionEngine({
    this.classToRemove,
    this.customRender,
    this.domain,
    this.context,
    Header h1,
    Header h2,
    Header h3,
    Header h4,
    Header h5,
    Header h6,
    Paragraph p,
    HRDivider hr,
  }) {
    this.h1 = h1 ?? Header(type: ElementType.h1);
    this.h2 = h2 ?? Header(type: ElementType.h2);
    this.h2 = h2 ?? Header(type: ElementType.h2);
    this.h3 = h3 ?? Header(type: ElementType.h3);
    this.h4 = h4 ?? Header(type: ElementType.h4);
    this.h5 = h5 ?? Header(type: ElementType.h5);
    this.h6 = h6 ?? Header(type: ElementType.h6);
    this.p = p ?? Paragraph();
    this.hr = hr ?? HRDivider();
  }

  void linkInterpolation(dom.Element node) {
    if (!disableLinks) {
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
                linkMap.links[id] = {
                    'href': href,
                    'type': 'internal',
                    'url_type': 'relative',
                  };
              }

              linkMap.links[id]['to_id'] = uri.fragment;
              linkMap.links[id]['link_text'] = link.text;
              link.text = '[FINDME_ID_${id}_ENDID_]';
            }
          }
        });
      }
    }
  }

  Widget copyWidgetWithText(dynamic inWidget, String text, [ String index ]){
    switch(inWidget.type) {
      case ElementType.h1:
      case ElementType.h2:
      case ElementType.h3:
      case ElementType.h4:
      case ElementType.h5:
      case ElementType.h6:
        return Header(
          padding: inWidget.padding,
          margin: inWidget.margin,
          color: inWidget.color,
          fontSize: inWidget.fontSize,
          type: inWidget.type,
          text: text,
          index: index,
        );
      case ElementType.p:
        return Paragraph(
          padding: inWidget.padding,
          margin: inWidget.margin,
          color: inWidget.color,
          fontSize: inWidget.fontSize,
          type: inWidget.type,
          text: text,
          index: index,
        );
      default:
        return Paragraph(
          padding: inWidget.padding,
          margin: inWidget.margin,
          color: inWidget.color,
          fontSize: inWidget.fontSize,
          type: inWidget.type,
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
        case elementTypeBElementType.h1:
          linkInterpolation(node);
          return copyWidgetWithText(h1, node.text, node.id);

        case element:
          linkInterpolation(node);
          return copyWidgetWithText(h2, node.text, node.id);

        case H3:
          linkInterpolation(node);
          return copyWidgetWithText(h3, node.text, node.id);

        case H4:
          linkInterpolation(node);
          return copyWidgetWithText(h4, node.text, node.id);

        case H5:
          linkInterpolation(node);
          return copyWidgetWithText(h5, node.text, node.id);

        case H6:
          linkInterpolation(node);
          return copyWidgetWithText(h6, node.text, node.id);

        case P:
          linkInterpolation(node);
          return copyWidgetWithText(p, node.text.replaceAll('\u00A0', ''), node.id);

        case HR:
          return copyWidgetWithText(hr);
        

        default:
          return null;
      }
    }
  }
}
