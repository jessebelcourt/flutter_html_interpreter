import 'package:flutter/material.dart';

enum ElementType {
  h1,
  h2,
  h3,
  h4,
  h5,
  h6,
  p,
}

class H1 extends TextBody {
  Color defaultColor = Colors.black;
  double defaultFontSize = 36;

  H1({text, style, padding, margin, color})
      : super(
            text: text,
            style: style,
            padding: padding,
            margin: margin,
            color: color);
}

class TextBody extends StatelessWidget {
  static final h1FontSize = 38;
  static final h2FontSize = 34;
  static final h3FontSize = 30;
  static final h4FontSize = 26;
  static final h5FontSize = 22;
  static final h6FontSize = 18;
  static final paragraphFontSize = 16;
  
  final text;
  final ElementType element;

  TextStyle style;
  EdgeInsets padding;
  EdgeInsets margin;
  Color color;
  double size;


  EdgeInsets defaultPadding = EdgeInsets.only(
    top: 5,
    bottom: 5,
  );
  Color defaultColor = Colors.black;
  double defaultFontSize = 16;

  TextBody({
    this.text = '',
    this.style,
    this.padding,
    this.margin,
    this.color,
    this.element,
  });

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

  Widget run(String type) {
    // switch(type) {
    //   case ConversionEngine.h1:
    //     return H1();
    // }
  }
}
