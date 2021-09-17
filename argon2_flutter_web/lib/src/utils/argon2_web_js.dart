@JS()
library main;

import 'package:js/js.dart';

@JS('Object.keys')
external List<String> getKeysOfObject(jsObject);

@JS('console.log')
external dynamic jsLog(Object args);

@JS('eval')
external dynamic jsEval(Object args);
