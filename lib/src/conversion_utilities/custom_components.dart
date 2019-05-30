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

class Paragraph extends TextBasedElement {
  Paragraph({
    padding,
    margin,
    text,
    fontSize,
  }) : super(
          padding: padding,
          margin: margin,
          text: text,
          fontSize: fontSize,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: text.toList(),
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
  }) : super(
          padding: padding,
          margin: margin,
          text: text,
          fontSize: fontSize,
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
  final EdgeInsets padding;
  final EdgeInsets margin;
  final List<TextSpan> text;
  final double fontSize;

  TextBasedElement({
    EdgeInsets this.padding,
    EdgeInsets this.margin,
    List<TextSpan> this.text,
    double this.fontSize,
  });

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
