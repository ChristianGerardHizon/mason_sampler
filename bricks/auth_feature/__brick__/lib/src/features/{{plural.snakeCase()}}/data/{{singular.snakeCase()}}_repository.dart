import 'dart:convert';
/// packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketbase/pocketbase.dart';
/// system
import 'package:{{packageName.snakeCase()}}/src/core/models/fields/{{singular.snakeCase()}}_fields.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/packages/flutter_secure_storage.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_data.dart';

part '{{singular.snakeCase()}}_repository.g.dart';

@Riverpod(keepAlive: true)
{{singular.pascalCase()}}Repository {{singular.snakeCase()}}Repository(Ref ref) {
  return {{singular.pascalCase()}}RepositoryImpl(
    storage: ref.read(flutterSecureStorageProvider),
    {{singular.pascalCase()}}Key: '{{singular.pascalCase()}}_KEY',
  );
}

abstract class {{singular.pascalCase()}}Repository {
  TaskResult<{{singular.pascalCase()}}Data> login(Map<String, dynamic> payload);
  TaskResult<void> logout();
  TaskResult<{{singular.pascalCase()}}Data> refresh();
  TaskResult<{{singular.pascalCase()}}Data> initialize();
}

class {{singular.pascalCase()}}RepositoryImpl implements {{singular.pascalCase()}}Repository {
  final FlutterSecureStorage storage;
  final String {{singular.pascalCase()}}Key;

  {{singular.pascalCase()}}RepositoryImpl({
    required this.storage,
    required this.{{singular.pascalCase()}}Key,
  });

  TaskResult<{{singular.pascalCase()}}Data> _saveToStorage(Map<String, dynamic> map) {
    return TaskResult.tryCatch(() async {
      final token = map['token'];
      final record = map['record'];

      {{singular.pascalCase()}}Data data = {{singular.pascalCase()}}Data(
        id: record.id,
        token: token,
      );
      ///
      /// store
      ///
      await storage.write(key: {{singular.pascalCase()}}Key, value: data.toJson());
      return data;
    }, Failure.handle);
  }

  TaskResult<{{singular.pascalCase()}}Data> login(
    Map<String, dynamic> payload,
    ) {
    return TaskResult<Map<String,dynamic>>.tryCatch(
      () async {
        final identity = payload[{{singular.pascalCase()}}Fields.identity];
        final password = payload[{{singular.pascalCase()}}Fields.password];

        throw UnimplementedError();
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    ).flatMap((x) => _saveToStorage(x));
  }

  TaskResult<void> logout() {
    return TaskResult.tryCatch(() async {
      await storage.delete(key: {{singular.pascalCase()}}Key);
    }, Failure.handle);
  }

  TaskResult<{{singular.pascalCase()}}Data> refresh() {
    return TaskResult.tryCatch(() async {
      
      throw UnimplementedError();

    }, Failure.handle).flatMap(_saveToStorage);
  }

  @override
  TaskResult<{{singular.pascalCase()}}Data> initialize() {
    return TaskResult.tryCatch(
      () async {
        ///
        /// token
        ///
        final {{singular.camelCase()}}UserString = await storage.read(key: {{singular.pascalCase()}}Key);

        if ({{singular.camelCase()}}UserString == null) {
          throw NoAuthFailure('{{singular.pascalCase()}}UserString is null', StackTrace.current);
        }

        final map = jsonDecode({{singular.camelCase()}}UserString);
        final oldtoken = map['token'];

        throw UnimplementedError();
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    );
  }
}
