@JS()
library main;

import 'package:js/js.dart';

@JS('Module')
@anonymous
class Module {
  static const allocator = 'i8';

  external Module._();

  @JS('ALLOC_NORMAL')
  external static int get allocModeNormal;

  @JS('HEAP8')
  external static List get heap8;

  @JS('HEAPU8')
  external static List get heapu8;

  @JS('HEAP16')
  external static List get heap16;

  @JS('HEAPU16')
  external static List get heapu16;

  @JS('HEAP32')
  external static List get heap32;

  @JS('HEAPU32')
  external static List get heapu32;

  @JS('HEAPF32')
  external static List get heapf32;

  @JS('HEAPF64')
  external static List get heapf64;

  @JS('allocate')
  external static int allocate(
    dynamic listOrLength,
    String allocator,
    int mode,
  );

  @JS('_argon2_encodedlen')
  external static int argon2EncodedLen(
    int tCost,
    int mCost,
    int parallelism,
    int saltlen,
    int hashlen,
    int argon2Type,
  );

  @JS('_argon2_error_message')
  external static int argon2ErrorMessage(int res);

  @JS('_argon2_hash_ext')
  external static int argon2HashExt(
    int tCost,
    int mCost,
    int parallelism,
    int pwd, // check type
    int pwdlen,
    int salt, // check type
    int saltlen,
    int hash, // check type
    int hashlen,
    int encoded, // check type
    int encodedlen,
    int argon2Type,
    int secret, // check type
    int secretlen,
    int ad, // check type
    int adlen,
    int version,
  );

  @JS('_free')
  external static dynamic free(int v);

  @JS('UTF8ToString')
  external static String utf8ToString(int encoded);
}
