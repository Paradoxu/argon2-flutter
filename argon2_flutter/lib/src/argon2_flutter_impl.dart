import 'dart:async';

import 'package:argon2_flutter_interface/argon2_flutter_interface.dart';

class Argon2Flutter {
  static Future<Argon2Result> hash(Argon2Params params) async {
    return Argon2FlutterInterface.instance.hash(params);
  }
}
