import 'dart:async';
import 'dart:js' as js;
import 'package:argon2_flutter_interface/argon2_flutter_interface.dart';

import 'src/utils/argon2_web_js.dart';
import 'src/wasm/module_impl.dart';
import 'package:flutter/services.dart' show rootBundle;

const String _assetsFolder = 'packages/argon2_flutter_web/assets';

class Argon2FlutterWeb extends Argon2FlutterInterface {
  WasmModule? _wasmModule;

  static void registerWith(_) {
    Argon2FlutterInterface.instance = Argon2FlutterWeb();
  }

  Future<void> _init(int maxMemory) async {
    if (_wasmModule != null) return;
    final completer = Completer<void>();

    final jsUtils =
        await rootBundle.loadString('$_assetsFolder/argon2-utils.js');
    jsEval(jsUtils);

    final memory = js.context.callMethod('createWasmMemory', [maxMemory]);

    final wasmBytes = await rootBundle.load('$_assetsFolder/argon2.wasm');
    js.context['Module'] = js.JsObject.jsify({
      'wasmBinary': wasmBytes.buffer.asInt8List(),
      'wasmMemory': memory,
      'postRun': js.allowInterop((_) {
        _wasmModule = WasmModule();
        completer.complete();
      }),
    });

    final wasmJs =
        await rootBundle.loadString('$_assetsFolder/argon2-module.js');

    /// Evaluate the javascript code and instantiate the WebAssembly modules
    jsEval(wasmJs);

    return completer.future;
  }

  @override
  Future<Argon2Result> hash(Argon2Params params) async {
    if (_wasmModule == null) await _init(params.memory);
    final res = _wasmModule!.hash(params);
    return Argon2Result.fromMap(res);
  }
}
