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
import 'package:{{packageName.snakeCase()}}/src/core/packages/pocketbase.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_data.dart';

part '{{singular.snakeCase()}}_repository.g.dart';

@Riverpod(keepAlive: true)
{{singular.pascalCase()}}Repository {{singular.snakeCase()}}Repository(Ref ref) {
  return {{singular.pascalCase()}}RepositoryImpl(
    storage: ref.read(flutterSecureStorageProvider),
    {{singular.pascalCase()}}Key: '{{singular.pascalCase()}}_KEY',
    pb: ref.read(pocketbaseProvider),
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
  final PocketBase pb;
  final String {{singular.pascalCase()}}Key;

  {{singular.pascalCase()}}RepositoryImpl({
    required this.pb,
    required this.storage,
    required this.{{singular.pascalCase()}}Key,
  });

  AuthStore get authStore => pb.authStore;

  TaskResult<{{singular.pascalCase()}}Data> _saveToStorage(RecordAuth record{{singular.pascalCase()}}) {
    return TaskResult.tryCatch(() async {
      final token = record{{singular.pascalCase()}}.token;
      final record = record{{singular.pascalCase()}}.record;

      {{singular.pascalCase()}}Data data = {{singular.pascalCase()}}Data(
        collectionName: record.collectionName,
        collectionId: record.collectionId,
        id: record.id,
        token: token,
      );
      ///
      /// store
      ///
      await storage.write(key: {{singular.pascalCase()}}Key, value: data.toJson());
      authStore.save(token, record);
      return data;
    }, Failure.handle);
  }

  TaskResult<{{singular.pascalCase()}}Data> login(
    Map<String, dynamic> payload,
    ) {
    return TaskResult.tryCatch(
      () async {
        final identity = payload[{{singular.pascalCase()}}Fields.identity];
        final password = payload[{{singular.pascalCase()}}Fields.password];

        return await pb
            .collection(payload[{{singular.pascalCase()}}Fields.type])
            .authWithPassword(
              identity,
              password
            );
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    ).flatMap((x) => _saveToStorage(x));
  }

  TaskResult<void> logout() {
    return TaskResult.tryCatch(() async {
      authStore.clear();
      await storage.delete(key: {{singular.pascalCase()}}Key);
    }, Failure.handle);
  }

  TaskResult<{{singular.pascalCase()}}Data> refresh() {
    return TaskResult.tryCatch(() async {
      final collection = authStore.record?.collectionName;

      if (collection == null) {
        throw DataFailure('collection is null', StackTrace.current);
      }

      return await pb.collection(collection).authRefresh();

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
        final oldCollection = map['collectionName'];
        authStore.save(oldtoken, null);

        final {{singular.snakeCase()}}Model = await pb
                  .collection(oldCollection)
                  .authRefresh();

        authStore.save({{singular.snakeCase()}}Model.token, {{singular.snakeCase()}}Model.record);

        final token = {{singular.snakeCase()}}Model.token;
        final record = {{singular.snakeCase()}}Model.record;

        return {{singular.pascalCase()}}Data(
          collectionName: record.collectionName,
          collectionId: record.collectionId,
          id: record.id,
          token: token,
        );
      },
      (error, stack) {
        return Failure.handle(error, stack);
      },
    );
  }
}
