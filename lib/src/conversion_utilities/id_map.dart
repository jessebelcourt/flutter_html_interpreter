import 'package:flutter/material.dart';

class IDMap {
  static final IDMap _singleton = IDMap._internal();
  Map<String, GlobalKey> ids = {};

  factory IDMap() {
    return _singleton;
  }

  IDMap._internal();
}