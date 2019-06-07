import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_interpreter/src/conversion_utilities/element_type.dart';

class HtmlPropertyModel {
  EdgeInsets margin;
  EdgeInsets padding;
  Color color;
  dynamic fontSize;
  String name;
  dynamic height;
  double iconSize;
  ElementType type;

  HtmlPropertyModel({
    this.margin,
    this.padding,
    this.color,
    this.fontSize,
    this.name,
    this.height,
    this.type,
  });
}

class ListHtmlPropertyModel extends HtmlPropertyModel {
  EdgeInsets listPadding;
  EdgeInsets listItemPadding;
  EdgeInsets listMargin;
  EdgeInsets listItemMargin;
  double iconGap;
  double iconSize;
  Color iconColor;

  ListHtmlPropertyModel({
    Color color,
    double fontSize,
    this.listPadding,
    this.listItemPadding,
    this.listMargin,
    this.listItemMargin,
    this.iconGap,
    this.iconSize,
    this.iconColor,
    String name,
    ElementType type,
  }) : super(
          fontSize: fontSize,
          color: color,
          name: name,
          type: type,
        );
}

class PropertyBuilder {
  static final Map<ElementType, HtmlPropertyModel> typeMapping = {
    ElementType.h1: PropertyBuilder.h1,
    ElementType.h2: PropertyBuilder.h2,
    ElementType.h3: PropertyBuilder.h3,
    ElementType.h4: PropertyBuilder.h4,
    ElementType.h5: PropertyBuilder.h5,
    ElementType.h5: PropertyBuilder.h6,
    ElementType.p: PropertyBuilder.p,
    ElementType.hr: PropertyBuilder.hr,
    ElementType.ul: PropertyBuilder.ul,
  };

  //===== Default Paddings/ Margins ===============

  static final EdgeInsets defaultHeaderMargin = EdgeInsets.only(
    top: 0,
    bottom: 0,
  );

  static final EdgeInsets defaultHeaderPadding = EdgeInsets.only(
    top: 5,
    bottom: 5,
  );

  static final EdgeInsets defaultParagraphPadding = EdgeInsets.only(
    top: 5,
    bottom: 5,
  );

  static final EdgeInsets defaultParagraphMargin = EdgeInsets.only(
    top: 0,
    bottom: 0,
  );

  static final EdgeInsets defaultListPadding = EdgeInsets.only(
    top: 5,
    bottom: 5,
    left: 10,
    right: 10,
  );

  static final EdgeInsets defaultListMargin = EdgeInsets.only(
    top: 0,
    bottom: 0,
  );

  static final EdgeInsets defaultListItemPadding = EdgeInsets.only(
    top: 0,
    bottom: 0,
  );

  static final EdgeInsets defaultListItemMargin = EdgeInsets.only(
    top: 0,
    bottom: 0,
  );

  static final double iconGap = 5.0;
  static final double iconSize = 10.0;
  static final Color iconColor = Colors.black;

  static final dynamic defaultHRHeight = 2.0;
  static final Color defaultHRColor = Colors.black;
  static final EdgeInsets defaultHRMargin = EdgeInsets.symmetric(vertical: 5);


  static final dynamic defaultH1FontSize = 38.0;
  static final dynamic defaultH2FontSize = 34.0;
  static final dynamic defaultH3FontSize = 30.0;
  static final dynamic defaultH4FontSize = 26.0;
  static final dynamic defaultH5FontSize = 22.0;
  static final dynamic defaultH6FontSize = 18.0;
  static final dynamic defaultParagraphFontSize = 16.0;
  static final dynamic defaultListFontSize = 16.0;

  static final Color color = Colors.black;

  static final HtmlPropertyModel h1 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH1FontSize,
    name: 'h1',
    type: ElementType.h1,
  );

  static HtmlPropertyModel h2 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH2FontSize,
    name: 'h2',
    type: ElementType.h2,
  );

  static HtmlPropertyModel h3 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH3FontSize,
    name: 'h3',
    type: ElementType.h3,
  );

  static HtmlPropertyModel h4 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH4FontSize,
    name: 'h4',
    type: ElementType.h4,
  );

  static HtmlPropertyModel h5 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH5FontSize,
    name: 'h5',
    type: ElementType.h5,
  );

  static HtmlPropertyModel h6 = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHeaderPadding,
    padding: PropertyBuilder.defaultHeaderPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultH6FontSize,
    name: 'h6',
    type: ElementType.h6,
  );

  static HtmlPropertyModel p = HtmlPropertyModel(
    margin: PropertyBuilder.defaultParagraphMargin,
    padding: PropertyBuilder.defaultParagraphPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultParagraphFontSize,
    name: 'p',
    type: ElementType.p,
  );

  static HtmlPropertyModel hr = HtmlPropertyModel(
    margin: PropertyBuilder.defaultHRMargin,
    color: PropertyBuilder.color,
    height: PropertyBuilder.defaultHRHeight,
    name: 'hr',
    type: ElementType.hr,
  );

  static ListHtmlPropertyModel ul = ListHtmlPropertyModel(
    listPadding: PropertyBuilder.defaultListPadding,
    listMargin: PropertyBuilder.defaultListMargin,
    listItemPadding: PropertyBuilder.defaultListItemPadding,
    listItemMargin: PropertyBuilder.defaultListItemPadding,
    color: PropertyBuilder.color,
    fontSize: PropertyBuilder.defaultListFontSize,
    iconGap: PropertyBuilder.iconGap,
    iconSize: PropertyBuilder.iconSize,
    iconColor: PropertyBuilder.iconColor,
    name: 'ul',
    type: ElementType.hr,
  );
}
