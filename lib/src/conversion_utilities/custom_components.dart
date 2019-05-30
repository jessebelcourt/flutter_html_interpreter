import 'package:flutter/material.dart';

class HRDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 2,
      color: Colors.black,
    );
  }
}

class Header extends StatelessWidget {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<TextSpan> text;
  final double fontSize;

  Header({
    EdgeInsets this.padding,
    EdgeInsets this.margin,
    List<TextSpan> this.text,
    double this.fontSize,
  });

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
