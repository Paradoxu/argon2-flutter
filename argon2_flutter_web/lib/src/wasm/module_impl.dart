import 'dart:typed_data';

import 'package:argon2_flutter_interface/argon2_flutter_interface.dart';

import '../extensions/x_string.dart';
import 'dart:convert' show utf8;

import 'module.dart';

class WasmModule {
  Map<String, dynamic> hash(Argon2Params params) {
    final tCost = params.iterations;
    final mCost = params.memory;
    final parallelism = params.parallelism;

    final pwdEncoded = Uint8List.fromList(utf8.encode(params.pass));
    final pwd = _allocateArrayStr(pwdEncoded);
    final pwdLen = pwdEncoded.length;

    final saltEncoded = Uint8List.fromList(utf8.encode(params.salt));
    final salt = _allocateArrayStr(saltEncoded);
    final saltLen = saltEncoded.length;

    final argon2Type = _argon2TypeToTypeId(params.type);
    final hash = _allocateArray(List.filled(params.hashLen, 0));

    final secret = params.secret != null ? _allocateArray(params.secret!) : 0;
    final secretLen = params.secret != null ? params.secret!.lengthInBytes : 0;

    final ad = params.ad != null ? _allocateArray(params.ad!) : 0;
    final adLen = params.ad != null ? params.ad!.lengthInBytes : 0;

    final hashlen = params.hashLen;
    final encodedLen = Module.argon2EncodedLen(
      tCost,
      mCost,
      parallelism,
      saltLen,
      hashlen,
      argon2Type,
    );
    final encoded = _allocateArray(List.filled(encodedLen + 1, 0));

    try {
      final res = Module.argon2HashExt(
        tCost,
        mCost,
        parallelism,
        pwd,
        pwdLen,
        salt,
        saltLen,
        hash,
        hashlen,
        encoded,
        encodedLen,
        argon2Type,
        secret,
        secretLen,
        ad,
        adLen,
        _argon2VersionToInt(params.version),
      );

      if (res != 0) {
        final err = Module.utf8ToString(Module.argon2ErrorMessage(res));
        throw Exception(err);
      }

      final hashString = StringBuffer();
      final hashArr = Uint8List(hashlen);

      for (var i = 0; i < hashlen; i++) {
        final byte = Module.heap8[hash + i];
        hashArr[i] = byte;
        hashString.write('0${(0xFF & byte).toRadixString(16)}'.lastChars(2));
      }

      final encodedStr = Module.utf8ToString(encoded);

      return {
        'rawHash': hashString.toString(),
        'rawHashBytes': hashArr,
        'encoded': encodedStr,
      };
    } catch (e) {
      print(e);
      rethrow;
    } finally {
      _freeParameters([
        pwd,
        salt,
        hash,
        encoded,
        ad,
        secret,
      ]);
    }
  }

  int _allocateArrayStr(List<int> data) {
    final list = Uint8List(data.length + 1);
    final nullTerminatedArray = list..setAll(0, [...data, 0]);
    return Module.allocate(
      nullTerminatedArray,
      Module.allocator,
      Module.allocModeNormal,
    );
  }

  int _allocateArray(List data) {
    return Module.allocate(
      data,
      Module.allocator,
      Module.allocModeNormal,
    );
  }

  void _freeParameters(List<int?> args) {
    try {
      args.where((e) => e != null).forEach((e) => Module.free(e!));
    } catch (e) {}
  }

  int _argon2TypeToTypeId(Argon2Type type) {
    switch (type) {
      case Argon2Type.Argon2d:
        return 0;
      case Argon2Type.Argon2i:
        return 1;
      case Argon2Type.Argon2id:
        return 2;
    }
  }

  int _argon2VersionToInt(Argon2Version version) {
    switch (version) {
      case Argon2Version.V10:
        return 0x10;
      case Argon2Version.V13:
        return 0x13;
    }
  }
}
