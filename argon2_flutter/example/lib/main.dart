import 'package:flutter/material.dart';

import 'package:argon2_flutter/argon2_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? encoded, hash, rawBytes;

  @override
  void initState() {
    super.initState();

    final params = Argon2Params(
      pass: 'testvalue',
      salt: 'randomsaltstring',
      iterations: 1,
      memory: 32,
      parallelism: 2,
      hashLen: 64,
      type: Argon2Type.Argon2i,
    );
    Argon2Flutter.hash(params).then((argon2Res) {
      setState(() {
        encoded = argon2Res.encoded;
        hash = argon2Res.rawHash;
        rawBytes = argon2Res.rawHashBytes.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Argon2 Flutter'),
        ),
        body: Container(
          padding: const EdgeInsetsDirectional.all(50),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Encoded: '),
                Text(encoded ?? ''),
                SizedBox(height: 20),
                Text('Hash: '),
                Text(hash ?? ''),
                SizedBox(height: 20),
                Text('Raw Bytes: '),
                Text(rawBytes ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
