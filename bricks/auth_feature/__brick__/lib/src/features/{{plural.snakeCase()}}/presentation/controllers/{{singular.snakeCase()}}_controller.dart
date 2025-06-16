import 'package:riverpod_annotation/riverpod_annotation.dart';

// system
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_data.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';

part '{{singular.snakeCase()}}_controller.g.dart';

@Riverpod(keepAlive: true)
class {{singular.pascalCase()}}Controller extends _${{singular.pascalCase()}}Controller {
  ///
  /// default no user failure
  ///
  final _noUserFailure = PresentationFailure('User not found');

  @override
  Future<{{singular.pascalCase()}}Data> build() async {
    final result = await ref
        .read({{singular.camelCase()}}RepositoryProvider)
        .initialize()
        .run()
        .timeout(const Duration(minutes: 1));

    return result.fold(
      (l) {
        ref.read({{singular.camelCase()}}RepositoryProvider).logout();
        throw l;
      },
      (user) async {
        return user;
      },
    );
  }

  TaskResult<{{singular.pascalCase()}}Data> setUser({{singular.pascalCase()}}Data? user) {
    if (user == null) {
      state = AsyncValue.error(_noUserFailure, StackTrace.current);
      return TaskResult.left(PresentationFailure('No User Failure'));
    }
    state = AsyncData(user);
    return TaskResult<{{singular.pascalCase()}}Data>.right(user);
  }

  TaskResult<{{singular.pascalCase()}}Data> refresh() {
    return ref.read({{singular.camelCase()}}RepositoryProvider).refresh().chainFirst(setUser);
  }

  TaskResult<{{singular.pascalCase()}}Data> login(Map<String, dynamic> map) {
    final repo = ref.read({{singular.camelCase()}}RepositoryProvider);
    return repo.login(map).chainFirst(setUser);
  }

  TaskResult<void> logout() {
    return ref
        .read({{singular.camelCase()}}RepositoryProvider)
        .logout()
        .chainFirst((_) => setUser(null));
  }
}
