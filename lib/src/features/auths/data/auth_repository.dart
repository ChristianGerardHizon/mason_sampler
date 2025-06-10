import 'dart:convert';
/// packages
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:pocketbase/pocketbase.dart';
/// system
import 'package:mason_sampler/src/core/models/fields/auth_fields.dart';
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';
import 'package:mason_sampler/src/core/packages/flutter_secure_storage.dart';
import 'package:mason_sampler/src/core/packages/pocketbase.dart';
import 'package:mason_sampler/src/features/auths/domain/auth_data.dart';

part 'auth_repository.g.dart';

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    storage: ref.read(flutterSecureStorageProvider),
    AuthKey: 'Auth_KEY',
    pb: ref.read(pocketbaseProvider),
  );
}

abstract class AuthRepository {
  TaskResult<AuthData> login(Map<String, dynamic> payload);
  TaskResult<void> logout();
  TaskResult<AuthData> refresh();
  TaskResult<AuthData> initialize();
}

class AuthRepositoryImpl implements AuthRepository {
  final FlutterSecureStorage storage;
  final PocketBase pb;
  final String AuthKey;

  AuthRepositoryImpl({
    required this.pb,
    required this.storage,
    required this.AuthKey,
  });

  AuthStore get authStore => pb.authStore;

  TaskResult<AuthData> _saveToStorage(RecordAuth recordAuth) {
    return TaskResult.tryCatch(() async {
      final token = recordAuth.token;
      final record = recordAuth.record;

      AuthData data = AuthData(
        collectionName: record.collectionName,
        collectionId: record.collectionId,
        id: record.id,
        token: token,
      );
      ///
      /// store
      ///
      await storage.write(key: AuthKey, value: data.toJson());
      authStore.save(token, record);
      return data;
    }, Failure.handle);
  }

  TaskResult<AuthData> login(
    Map<String, dynamic> payload,
    ) {
    return TaskResult.tryCatch(
      () async {
        final identity = payload[AuthFields.identity];
        final password = payload[AuthFields.password];

        return await pb
            .collection(payload[AuthFields.type])
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
      await storage.delete(key: AuthKey);
    }, Failure.handle);
  }

  TaskResult<AuthData> refresh() {
    return TaskResult.tryCatch(() async {
      final collection = authStore.record?.collectionName;

      if (collection == null) {
        throw DataFailure('collection is null', StackTrace.current);
      }

      return await pb.collection(collection).authRefresh();

    }, Failure.handle).flatMap(_saveToStorage);
  }

  @override
  TaskResult<AuthData> initialize() {
    return TaskResult.tryCatch(
      () async {
        ///
        /// token
        ///
        final authUserString = await storage.read(key: AuthKey);

        if (authUserString == null) {
          throw NoAuthFailure('AuthUserString is null', StackTrace.current);
        }

        final map = jsonDecode(authUserString);
        final oldtoken = map['token'];
        final oldCollection = map['collectionName'];
        authStore.save(oldtoken, null);

        final authModel = await pb
                  .collection(oldCollection)
                  .authRefresh();

        authStore.save(authModel.token, authModel.record);

        final token = authModel.token;
        final record = authModel.record;

        return AuthData(
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
