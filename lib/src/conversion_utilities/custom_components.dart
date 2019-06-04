import 'package:blog_parser/src/conversion_utilities/id_map.dart';
import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:flutter/gestures.dart';
import 'package:blog_parser/src/conversion_utilities/link_map.dart';
import 'package:blog_parser/src/conversion_utilities/id_map.dart';
import 'package:blog_parser/src/conversion_utilities/bus.dart';

class HRDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      color: Colors.black,
    );
  }
}

class Paragraph extends StatefulWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final String text;
  final double fontSize;
  final ElementType type;
  final Color color;
  final String index;

  Paragraph({
    this.padding,
    this.margin,
    this.text,
    this.fontSize,
    this.type,
    this.color,
    this.index,
  });

  @override
  ParagraphState createState() => ParagraphState();
}

class Header extends StatefulWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final String text;
  final double fontSize;
  final ElementType type;
  final Color color;
  final String index;

  Header({
    this.padding,
    this.margin,
    this.text,
    this.fontSize,
    this.type,
    this.color,
    this.index,
  });

  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> with TextElementStateMixin {
  ElementType defaultElementType = ElementType.h1;
  double defaultFontSize = H1_FONT_SIZE;

  @override
  void initState() {
    super.initState();
    if (type != null) {
      fontSize = defaultFontSizes[type];
    }
    padding = widget.padding ?? defaultPadding;
    margin = widget.margin ?? defaultMargin;
    fontSize = widget.fontSize ?? defaultFontSize;
    color = widget.color ?? defaultColor;
    type = widget.type ?? defaultElementType;
    text = widget.text ?? '';
    index = widget.index ?? index;

    if (index.isNotEmpty && index != null) {
      _key = GlobalKey();
      idMap.ids[index] = _key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Container(
            key: _key,
            padding: padding,
            margin: margin,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                ),
                children: buildContent(text, context),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class ParagraphState extends State<Paragraph> with TextElementStateMixin {
  @override
  void initState() {
    super.initState();
    padding = widget.padding ?? defaultPadding;
    margin = widget.margin ?? defaultMargin;
    fontSize = widget.fontSize ?? defaultFontSize;
    color = widget.color ?? defaultColor;
    type = widget.type ?? defaultElementType;
    text = widget.text ?? '';
    index = widget.index ?? index;
    if (index.isNotEmpty && index != null) {
      _key = GlobalKey();
      idMap.ids[index] = _key;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _key,
      padding: padding,
      margin: margin,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: color,
            fontSize: fontSize,
          ),
          children: buildContent(text, context),
        ),
      ),
    );
  }
}

mixin TextElementStateMixin {
  Map<ElementType, double> defaultFontSizes = {
    ElementType.h1: H1_FONT_SIZE,
    ElementType.h2: H2_FONT_SIZE,
    ElementType.h3: H3_FONT_SIZE,
    ElementType.h4: H4_FONT_SIZE,
    ElementType.h5: H5_FONT_SIZE,
    ElementType.h6: H6_FONT_SIZE,
    ElementType.p: P_FONT_SIZE,
  };

  IDMap idMap = IDMap();
  LinkMap linkMap = LinkMap();
  Bus bus = Bus();
  String index;
  GlobalKey _key;
  EdgeInsets padding;
  EdgeInsets margin;
  Color color;
  double fontSize;
  String text;
  ElementType type;
  // Default Values
  EdgeInsets defaultPadding = EdgeInsets.all(0);
  EdgeInsets defaultMargin = EdgeInsets.all(0);
  Color defaultColor = Colors.black;
  double defaultFontSize = P_FONT_SIZE;
  ElementType defaultElementType = ElementType.p;

  List<TextSpan> buildContent(String textIn, BuildContext context) {
    textIn = textIn ?? '';
    RegExp re = RegExp(r'\[FINDME_ID_(.*?)_ENDID_\]');
    String findMe;

    const String FINDME_END = '[/FINDME]';
    String temp = textIn;
    List<TextSpan> result = [];
    int indexStart;
    int indexEnd;

    if (re.hasMatch(temp)) {
      while (temp.isNotEmpty) {
        Match m = re.firstMatch(temp);
        String tag = (m != null ? m.group(0) : null);
        indexStart = (tag != null ? temp.indexOf(tag) : -1);
        indexEnd = temp.indexOf(FINDME_END);
        TextSpan input;

        if (indexStart > -1 && indexEnd > -1) {
          Match match = re.firstMatch(temp);
          findMe = match.group(0);
          String id = match.group(1);

          if (indexStart == 0) {
            // adding link
            input = TextSpan(
              text: temp.substring(findMe.length, indexEnd),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Map<String, String> link = linkMap.links[id];
                  GlobalKey destinationKey;

                  idMap.ids.keys.forEach((key) {
                    if (key == link['to_id']) {
                      destinationKey = idMap.ids[key];
                    }
                  });

                  final RenderBox renderbox =
                      destinationKey.currentContext.findRenderObject();
                  final position = renderbox.localToGlobal(Offset.zero);
                  print('position of $destinationKey: $position');
                  print(position.dy);
                  bus.screenPosition.add(position.dy);
                },
              // ..onTap = () => print(linkMap.links[id]),
              style: TextStyle(
                color: Colors.red,
              ),
            );
            result.add(input);
            temp = temp.substring(indexEnd + FINDME_END.length);
          } else if (indexStart > 0) {
            // Not a link
            input = TextSpan(text: temp.substring(0, indexStart));
            result.add(input);
            temp = temp.substring(indexStart);
          } else if (temp.isNotEmpty) {
            input = TextSpan(text: temp);
            result.add(input);
            temp = '';
          }
        } else if (temp.isNotEmpty) {
          input = TextSpan(text: temp);
          result.add(input);
          temp = '';
        }
      }
    } else {
      return [TextSpan(text: textIn)];
    }

    return result;
  }
}
