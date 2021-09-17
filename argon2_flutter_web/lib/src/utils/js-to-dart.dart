import 'dart:js_util';

import 'argon2_web_js.dart';

/// A workaround to converting an object from JS to a Dart Map.
Map<String, dynamic> jsToMap(jsObject) {
  return new Map.fromIterable(
    getKeysOfObject(jsObject),
    value: (key) => getProperty(jsObject, key),
  );
}

Object mapToJSObj(Map<dynamic, dynamic> a) {
  var object = newObject();
  a.forEach((k, v) {
    var key = k;
    var value = v;
    setProperty(object, key, value);
  });
  return object;
}
