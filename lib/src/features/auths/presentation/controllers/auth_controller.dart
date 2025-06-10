import 'package:riverpod_annotation/riverpod_annotation.dart';

// system
import 'package:mason_sampler/src/features/auths/data/auth_repository.dart';
import 'package:mason_sampler/src/features/auths/domain/auth_data.dart';
import 'package:mason_sampler/src/core/models/failure.dart';
import 'package:mason_sampler/src/core/models/type_defs.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  ///
  /// default no user failure
  ///
  final _noUserFailure = PresentationFailure('User not found');

  @override
  Future<AuthData> build() async {
    final result = await ref
        .read(authRepositoryProvider)
        .initialize()
        .run()
        .timeout(const Duration(minutes: 1));

    return result.fold(
      (l) {
        ref.read(authRepositoryProvider).logout();
        throw l;
      },
      (user) async {
        return user;
      },
    );
  }

  TaskResult<AuthData> setUser(AuthData? user) {
    if (user == null) {
      state = AsyncValue.error(_noUserFailure, StackTrace.current);
      return TaskResult.left(PresentationFailure('No User Failure'));
    }
    state = AsyncData(user);
    return TaskResult<AuthData>.right(user);
  }

  TaskResult<AuthData> refresh() {
    return ref.read(authRepositoryProvider).refresh().chainFirst(setUser);
  }

  TaskResult<AuthData> login(AuthDataType type, Map<String, dynamic> map) {
    final repo = ref.read(authRepositoryProvider);
    return repo.login(map).chainFirst(setUser);
  }

  TaskResult<void> logout() {
    return ref
        .read(authRepositoryProvider)
        .logout()
        .chainFirst((_) => setUser(null));
  }
}
