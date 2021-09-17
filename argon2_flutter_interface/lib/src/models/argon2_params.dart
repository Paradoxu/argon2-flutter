import 'dart:typed_data';

import 'argon2_enums.dart';

class Argon2Params {
  final String pass;
  final String salt;

  /// the number of iterations
  final int iterations;

  /// used memory, in KiB
  final int memory;

  /// desired hash length
  final int hashLen;

  /// desired parallelism (it won't be computed in parallel, however)
  final int parallelism;

  /// optional secret data
  final Uint8List? secret;

  /// optional associated data
  final Uint8List? ad;

  final Argon2Type type;
  final Argon2Version version;

  Argon2Params({
    required this.pass,
    required this.salt,
    this.iterations = 1,
    this.memory = 1024,
    this.hashLen = 24,
    this.parallelism = 1,
    this.secret,
    this.ad,
    this.type = Argon2Type.Argon2d,
    this.version = Argon2Version.V13,
  });

  Map<String, dynamic> toMap() {
    return {
      'pass': pass,
      'salt': salt,
      'iterations': iterations,
      'memory': memory,
      'hashLen': hashLen,
      'parallelism': parallelism,
      'secret': secret,
      'ad': ad,
      'type': type.toString(),
      'version': version.toString(),
    };
  }
}
