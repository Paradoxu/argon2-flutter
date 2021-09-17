import 'dart:async';

import 'package:argon2_flutter_interface/argon2_flutter_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'argon2_flutter_interface_channel.dart';

abstract class Argon2FlutterInterface extends PlatformInterface {
  Argon2FlutterInterface() : super(token: _token);

  static final Object _token = Object();
  static Argon2FlutterInterface _instance = Argon2FlutterChannel();

  static Argon2FlutterInterface get instance => _instance;

  static set instance(Argon2FlutterInterface ist) {
    PlatformInterface.verifyToken(ist, _token);
    _instance = ist;
  }

  Future<Argon2Result> hash(Argon2Params params);
}
