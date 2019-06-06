import 'package:html_interpreter/src/conversion_utilities/id_map.dart';
import 'package:flutter/material.dart';
import 'package:html_interpreter/src/conversion_utilities/style_values.dart';
import 'package:html_interpreter/src/conversion_utilities/element_type.dart';
import 'package:flutter/gestures.dart';
import 'package:html_interpreter/src/conversion_utilities/link_map.dart';
import 'package:html_interpreter/src/conversion_utilities/bus.dart';
import 'package:url_launcher/url_launcher.dart';

class HR extends StatefulWidget {
  final Color color;
  final EdgeInsets margin;
  final dynamic height;
  final ElementType type;

  HR({
    this.color,
    this.margin,
    this.height,
    this.type,
  });

  _HRState createState() => _HRState();
}

class _HRState extends State<HR> {
  Color color;
  dynamic height;
  EdgeInsets margin;
  ElementType type;

  @override
  void initState() {
    super.initState();
    type = ElementType.hr;
    HtmlPropertyModel model = PropertyBuilder.typeMapping[type];
    color = widget.color ?? model.color;
    height = widget.height ?? model.height;
    margin = widget.margin ?? model.margin;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Divider(
        color: color,
        height: height,
      ),
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

class ParagraphState extends State<Paragraph> with TextElementStateMixin {
  @override
  void initState() {
    super.initState();
    // This has all the defaults
    type = widget.type ?? ElementType.p;
    HtmlPropertyModel model = PropertyBuilder.typeMapping[type];

    padding = widget.padding ?? model.padding;
    margin = widget.margin ?? model.margin;
    fontSize = widget.fontSize ?? model.fontSize;
    color = widget.color ?? model.color;
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
  @override
  void initState() {
    super.initState();
    type = widget.type ?? ElementType.h1;
    HtmlPropertyModel model = PropertyBuilder.typeMapping[type];

    padding = widget.padding ?? model.padding;
    margin = widget.margin ?? model.margin;
    fontSize = widget.fontSize ?? model.fontSize;
    color = widget.color ?? model.color;
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
                  color: color,
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

class UnorderdList extends StatefulWidget {
  final Color color;
  final double fontSize;
  final EdgeInsets listPadding;
  final EdgeInsets listMargin;
  final EdgeInsets listItemPadding;
  final EdgeInsets listItemMargin;
  final List<String> listItems;
  final double iconGap;
  final double iconSize;
  final Color iconColor;
  final ElementType type;
  final String index;

  UnorderdList({
    this.color,
    this.fontSize,
    this.listPadding,
    this.listMargin,
    this.listItemPadding,
    this.listItemMargin,
    this.listItems,
    this.iconGap,
    this.iconSize,
    this.iconColor,
    this.type,
    this.index,
  });

  _UnorderdListState createState() => _UnorderdListState();
}

class _UnorderdListState extends State<UnorderdList> {
  Color color;
  double fontSize;
  EdgeInsets listPadding;
  EdgeInsets listMargin;
  EdgeInsets listItemPadding;
  EdgeInsets listItemMargin;
  List<String> listItems;
  double iconGap;
  double iconSize;
  Color iconColor;
  ElementType type;

  @override
  void initState() {
    super.initState();
    type = ElementType.ul;
    ListHtmlPropertyModel model = PropertyBuilder.typeMapping[type];

    color = widget.color ?? model.color;
    fontSize = widget.fontSize ?? model.fontSize;
    listPadding = widget.listPadding ?? model.listPadding;
    listMargin = widget.listMargin ?? model.listMargin;
    listItemPadding = widget.listItemPadding ?? model.listItemPadding;
    listItemMargin = widget.listItemMargin ?? model.listItemMargin;
    listItems = widget.listItems ?? [""];
    iconGap = widget.iconGap ?? model.iconGap;
    iconSize = widget.iconSize ?? model.iconSize;
    iconColor = widget.iconColor ?? model.iconColor;
  }

  List<Widget> listItem(List<String> content) {
    print(iconColor);
    List<Widget> listItems = content.map((item) {
      return Container(
        padding: listItemPadding,
        margin: listItemMargin,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: fontSize,
              padding: EdgeInsets.only(
                top: 3,
                right: iconGap,
              ),
              child: Icon(
                Icons.brightness_1,
                size: iconSize,
                color: iconColor,
              ),
            ),
            Expanded(
              child: Container(
                child: Text(
                  (item.isNotEmpty ? item : ''),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    if (listItems != null && listItems.isNotEmpty) {
      return Container(
        padding: listPadding,
        margin: listMargin,
        child: Column(
          children: listItem(listItems),
        ),
      );
    } else {
      return Container();
    }
  }
}

mixin TextElementStateMixin {
  void handleLinkClick(String id) {
    if (id != null && id.isNotEmpty) {
      Map<String, String> link = linkMap.links[id];
      if (link['type'] == 'external') {
        handleExternalLink(link['href']);
      }

      GlobalKey destinationKey;
      idMap.ids.keys.forEach((key) {
        if (key == link['to_id']) {
          destinationKey = idMap.ids[key];
        }
      });

      if (destinationKey != null) {
        RenderBox renderbox = destinationKey.currentContext.findRenderObject();
        var position = renderbox.localToGlobal(Offset.zero);
        bus.screenPosition.add(position.dy - renderbox.size.height);
      }
    }
  }

  void handleExternalLink(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

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

  List<TextSpan> buildContent(String textIn, BuildContext context) {
    textIn = textIn ?? '';
    RegExp re = RegExp(r'\[FINDME_ID_(.*?)_ENDID_\]');
    String findMe;
    String temp = textIn;
    List<TextSpan> result = [];
    int indexStart;

    if (re.hasMatch(temp)) {
      while (temp.isNotEmpty) {
        Match m = re.firstMatch(temp);
        String tag = (m != null ? m.group(0) : null);
        indexStart = (tag != null ? temp.indexOf(tag) : -1);
        TextSpan input;

        if (indexStart > -1) {
          Match match = re.firstMatch(temp);
          findMe = match.group(0);
          String id = match.group(1);

          if (indexStart == 0) {
            // adding link
            input = TextSpan(
              text: linkMap.links[id]['link_text'],
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  handleLinkClick(id);
                },
              style: TextStyle(
                color: Colors.red,
              ),
            );
            result.add(input);
            temp = temp.substring(findMe.length);
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
