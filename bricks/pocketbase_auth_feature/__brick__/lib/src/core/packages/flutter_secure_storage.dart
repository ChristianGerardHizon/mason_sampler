import 'package:universal_io/io.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'flutter_secure_storage.g.dart';

@Riverpod(keepAlive: true)
FlutterSecureStorage flutterSecureStorage(Ref ref) {
  // if android
  if (Platform.isAndroid) {
    return const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  } else {
    return const FlutterSecureStorage();
  }
}
