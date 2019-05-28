import 'package:flutter/material.dart';
import 'package:blog_parser/src/conversion_utilities/element_type.dart';
import 'package:blog_parser/src/conversion_utilities/style_values.dart';
import 'package:html/dom.dart' as dom;


class TextBody extends StatelessWidget {
  static final double h1FontSize = H1_FONT_SIZE;
  static final double h2FontSize = H2_FONT_SIZE;
  static final double h3FontSize = H3_FONT_SIZE;
  static final double h4FontSize = H4_FONT_SIZE;
  static final double h5FontSize = H5_FONT_SIZE;
  static final double h6FontSize = H6_FONT_SIZE;
  static final double pFontSize = P_FONT_SIZE;
  
  String text;
  ElementType element;

  TextStyle style;
  EdgeInsets padding;
  EdgeInsets margin;
  Color color;
  double size;

  EdgeInsets defaultPadding;
  EdgeInsets defaultMargin;
  Color defaultColor;
  double defaultFontSize;

  TextBody({
    text = '',
    style,
    padding,
    margin,
    color,
    element = ElementType.p,
  }) {

    //need to have conditional logic where precedence will 
    // take place based on what is passed.
    this.text = text;
    this.style = style;
    this.padding = padding;
    this.color = color;
    this.element = element;
    setDefaultStyle(element);
  }

  void setH1ElementDefaults() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.h1FontSize;
  }
  void setH2ElementsDefault() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.h2FontSize;
  }
  void setH3ElementDefaults() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.h3FontSize;
  }
  void setH4ElementDefaults() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.h4FontSize;;
  }
  void setH5ElementDefaults() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.h5FontSize;;
  }
  void setH6ElementDefaults() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.h6FontSize;
  }
  void setParagraphElementDefaults() {
    defaultPadding = EdgeInsets.only(
      top: 5,
      bottom: 5,
    );
    defaultColor = Colors.black;
    defaultFontSize = TextBody.pFontSize;
  }

  void setDefaultStyle(ElementType type) {
    switch (type) {
      case ElementType.h1:
        setH1ElementDefaults();
        break;
      case ElementType.h2:
        setH1ElementDefaults();
        break;
      case ElementType.h3:
        setH1ElementDefaults();
        break;
      case ElementType.h4:
        setH1ElementDefaults();
        break;
      case ElementType.h5:
        setH1ElementDefaults();
        break;
      case ElementType.h6:
        setH1ElementDefaults();
        break;
      default:
        setParagraphElementDefaults();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (padding != null) ? padding : defaultPadding,
      child: Text(
        text,
        style: TextStyle(
          color: (color != null) ? color : defaultColor,
          fontSize: (size != null) ? size : defaultFontSize,
        ),
      ),
    );
  }
}

class ConversionEngine {
  static const String h1 = 'h1';
  static const String h2 = 'h2';
  static const String h3 = 'h3';
  static const String h4 = 'h4';
  static const String h5 = 'h5';
  static const String h6 = 'h6';
  
  ConversionEngine();

  Widget run(dom.Node node, List<Widget> children) {
    if (node is dom.Element) {
      switch (node.localName) {

        case ConversionEngine.h1:
          return TextBody(
            text: node.text,
            element: ElementType.h1,
          );

        case ConversionEngine.h2:
          return TextBody(
            text: node.text,
            element: ElementType.h2,
          );

        case ConversionEngine.h3:
          return TextBody(
            text: node.text,
            element: ElementType.h3,
          );
        case ConversionEngine.h4:
          return TextBody(
            text: node.text,
            element: ElementType.h4,
          );
        case ConversionEngine.h5:
          return TextBody(
            text: node.text,
            element: ElementType.h5,
          );
        case ConversionEngine.h6:
          return TextBody(
            text: node.text,
            element: ElementType.h6,
          );

        default:
          return null;
      }
    }
  }
}
