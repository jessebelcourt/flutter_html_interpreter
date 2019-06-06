class LinkMap {
  static final LinkMap _singleton = LinkMap._internal();
  Map<String, Map<String, dynamic>> links = {};

  factory LinkMap() {
    return _singleton;
  }

  LinkMap._internal();
}