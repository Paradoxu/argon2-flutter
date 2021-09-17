import 'dart:async';
import 'dart:typed_data';

import 'package:argon2_flutter_interface/argon2_flutter_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const _channel = MethodChannel('argon2_flutter');

class Argon2FlutterChannel extends Argon2FlutterInterface {
  @override
  Future<Argon2Result> hash(Argon2Params params) async {
    final mapParams = {
      'pass': params.pass,
      'salt': params.salt,
      'iterations': params.iterations,
      'memory': params.memory,
      'hashLen': params.hashLen,
      'parallelism': params.parallelism,
      'mode': describeEnum(params.type),
      'version': describeEnum(params.version),
    };

    final res = await _channel.invokeMethod('hash', [mapParams]);

    return Argon2Result(
      encoded: res['encoded'],
      rawHashBytes: Uint8List.fromList(res['rawHashBytes']),
      rawHash: res['rawHash'],
    );
  }
}
