import 'dart:typed_data';

class Argon2Result {
  String encoded;
  Uint8List rawHashBytes;

  /// Raw hash in HEX string
  String rawHash;

  Argon2Result({
    required this.rawHashBytes,
    required this.encoded,
    required this.rawHash,
  });

  factory Argon2Result.fromMap(Map<String, dynamic> map) {
    return Argon2Result(
      rawHashBytes: map['rawHashBytes'],
      encoded: map['encoded'],
      rawHash: map['rawHash'],
    );
  }

  @override
  String toString() =>
      'Argon2Result(encoded: $encoded, rawHashBytes: $rawHashBytes, rawHash: $rawHash)';
}
