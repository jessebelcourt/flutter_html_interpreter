import 'package:flutter/material.dart';
import 'package:html_interpreter/src/conversion_utilities/element_type.dart';

const H1 = 'h1';
const H2 = 'h2';
const H3 = 'h3';
const H4 = 'h4';
const H5 = 'h5';
const H6 = 'h6';
const P = 'p';
const HR = 'hr';

class HtmlPropertyModel {
  EdgeInsets margin;
  EdgeInsets padding;
  Color color;
  dynamic fontSize;
  String name;

  HtmlPropertyModel({
    this.margin,
    this.padding,
    this.color,
    this.fontSize,
    this.name,
  });
}

class PropertyBuilder {
  static final EdgeInsets defaultHeaderMargin = EdgeInsets.only(
    top: 0,
    bottom: 0,
  );

  static final EdgeInsets defaultHeaderPadding = EdgeInsets.only(
    top: 5,
    bottom: 5,
  );

  static final dynamic defaultH1FontSize = 38.0;
  static final dynamic defaultH2FontSize = 34.0;
  static final dynamic defaultH3FontSize = 30.0;
  static final dynamic defaultH4FontSize = 26.0;
  static final dynamic defaultH5FontSize = 22.0;
  static final dynamic defaultH6FontSize = 18.0;

  static final dynamic defaultParagraphFontSize = 16.0;

  static final Color color = Colors.black;

  static HtmlPropertyModel h1 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH1FontSize,
    name: 'h1',
  );

  static HtmlPropertyModel h2 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH2FontSize,
    name: 'h2',
  );
  
  static HtmlPropertyModel h3 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH3FontSize,
    name: 'h3',
  );

  static HtmlPropertyModel h4 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH4FontSize,
    name: 'h4',
  );

  static HtmlPropertyModel h5 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH5FontSize,
    name: 'h5',
  );

  static HtmlPropertyModel h6 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH6FontSize,
    name: 'h6',
  );

  static HtmlPropertyModel p = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultParagraphFontSize,
    name: 'p',
  );
}

// Map<ElementType, <Map<String, dynamic>>> elementTypeTagName = {
const Map<ElementType, dynamic> elementTypeTagName = {
  // ElementType.h1: 'h1',

  ElementType.h2: 'h2',
  ElementType.h3: 'h3',
  ElementType.h4: 'h4',
  ElementType.h5: 'h5',
  ElementType.h6: 'h6',
  ElementType.hr: 'hr',
  ElementType.p: 'p',
};

const H1_FONT_SIZE = 38.0;
const H2_FONT_SIZE = 34.0;
const H3_FONT_SIZE = 30.0;
const H4_FONT_SIZE = 26.0;
const H5_FONT_SIZE = 22.0;
const H6_FONT_SIZE = 18.0;

const P_FONT_SIZE = 16.0;

// Default Paragraph
const EdgeInsets defaultParagraphPadding = EdgeInsets.only(top: 10, bottom: 10);
const EdgeInsets defaultParagraphMargin = EdgeInsets.all(0);

const EdgeInsets defaultPadding = EdgeInsets.all(0);
const EdgeInsets defaultMargin = EdgeInsets.all(0);
const List<TextSpan> defaultText = [TextSpan(text: '')];
const Color defaultHeaderColor = Colors.black;
const double defaultFontSize = P_FONT_SIZE;

// HR defaults
const EdgeInsets defaultHRMargin = EdgeInsets.only(top: 3, bottom: 3);
const Color defaultHRColor = Colors.black;
const dynamic defaultHRHeight = 2;
