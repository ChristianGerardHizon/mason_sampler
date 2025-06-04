
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '{{singular.snakeCase()}}_controller.g.dart';

@riverpod
class {{singular.pascalCase()}}Controller extends _${{singular.pascalCase()}}Controller {
  @override
  Future<{{singular.pascalCase()}}> build(String id) async {
    final repo = ref.read({{singular.camelCase()}}RepositoryProvider);
    final result = await repo.get(id).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
