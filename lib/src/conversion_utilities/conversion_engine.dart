import 'package:flutter/material.dart';


class H1 extends StatelessWidget {
  final text;
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
  double defaultFontSize = 32;

  H1({
    this.text = '',
    this.style,
    this.padding,
    this.margin,
    this.color,
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
