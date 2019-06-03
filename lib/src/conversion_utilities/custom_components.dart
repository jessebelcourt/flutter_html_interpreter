import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:flutter/gestures.dart';

class HRDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      color: Colors.black,
    );
  }
}

class Paragraph extends TextBasedElement {
  Paragraph({
    padding,
    margin,
    text,
    fontSize,
    type,
  }) : super(
          padding: padding,
          margin: margin,
          text: text,
          fontSize: fontSize,
          type: type,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
          children: text,
        ),
      ),
    );
  }
}

class Header extends TextBasedElement {
  Header({
    padding,
    margin,
    text,
    fontSize,
    type,
  }) : super(
    padding: padding,
    margin: margin,
    text: text,
    fontSize: fontSize,
    type: type,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Flexible(
          child: Container(
            padding: padding,
            margin: margin,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                ),
                children: text,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class TextBasedElement extends StatelessWidget {
  
  static Map<ElementType, double> defaultFontSizes = {
    ElementType.h1: H1_FONT_SIZE,
    ElementType.h2: H2_FONT_SIZE,
    ElementType.h3: H3_FONT_SIZE,
    ElementType.h4: H4_FONT_SIZE,
    ElementType.h5: H5_FONT_SIZE,
    ElementType.h6: H6_FONT_SIZE,
    ElementType.p: P_FONT_SIZE,
  };

  final EdgeInsets defaultHeaderPadding = EdgeInsets.all(0);
  final EdgeInsets defaultHeaderMargin = EdgeInsets.all(0);
  final EdgeInsets defaultParPadding = EdgeInsets.all(0);
  final EdgeInsets defaultParMargin = EdgeInsets.only(top: 5, bottom: 5);

  EdgeInsets padding;
  EdgeInsets margin;
  List<TextSpan> text;
  double fontSize;
  ElementType type;
  TextStyle linkStyle;
  TextStyle defaultLinkStyle = TextStyle(
    color: Colors.blue,
    decoration: TextDecoration.underline,
  );

  TextBasedElement({
    EdgeInsets padding,
    EdgeInsets margin,
    List<TextSpan> text,
    double fontSize,
    ElementType type,
  }) {
      this.type = type ?? ElementType.p;
      setDefaults(type);
      
      // over ride defaults is set by user
      if (padding != null) {
        this.padding = padding;
      }

      if (margin != null) {
        this.margin = margin;
      }

      if (fontSize != null) {
        this.fontSize = fontSize;
      }

      if (text == null) {
        text = <TextSpan>[TextSpan(text: '')];
      } else {
        this.text = text;
      }
  }

  List<TextSpan> buildContent(String textIn) {
    textIn = textIn ?? '';
    int index = textIn.indexOf('[FINDME]');

    const String FINDME = '[FINDME]';
    const String FINDME_END = '[/FINDME]';
    String temp = textIn;
    List<TextSpan> result = [];
    int indexStart;
    int indexEnd;

    //replace with link
    if (index >= 0) {
      while (temp.isNotEmpty) {
        indexStart = temp.indexOf(FINDME);
        indexEnd = temp.indexOf(FINDME_END);
        TextSpan input;

        if (indexStart > -1 && indexEnd > -1) {
          if (indexStart == 0) {
            // adding link
            input = TextSpan(
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

  Widget cloneWithText(String textIn) {
    List<TextSpan> content = buildContent(textIn);
    print(content);

    switch (type) {
      case ElementType.h1:
      case ElementType.h2:
      case ElementType.h3:
      case ElementType.h4:
      case ElementType.h5:
      case ElementType.h6:
        return Header(
          padding: this.padding,
          margin: this.margin,
          fontSize: this.fontSize,
          text: content,
          type: type,
        );
        break;
      case ElementType.p:
        return Paragraph(
          padding: this.padding,
          margin: this.margin,
          fontSize: this.fontSize,
          type: type,
          text: content,
        );
        break;
      default:
        return Paragraph(
          padding: this.padding,
          margin: this.margin,
          fontSize: this.fontSize,
          type: type,
          text: content,
        );
    }
  }

  void setDefaults(ElementType type) {
    switch(type) {
      case ElementType.h1:
      case ElementType.h2:
      case ElementType.h3:
      case ElementType.h4:
      case ElementType.h5:
      case ElementType.h6:
        padding = defaultHeaderPadding;
        margin = defaultHeaderMargin;
        fontSize = defaultFontSizes[type];
        break;
      case ElementType.p:
        padding = defaultParPadding;
        margin = defaultParMargin;
        fontSize = defaultFontSizes[type];
        break;
      default:
        padding = defaultParPadding;
        margin = defaultParMargin;
        fontSize = defaultFontSizes[type];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: RichText(
        text: TextSpan(
          children: text,
        ),
      ),
    );
  }
}
