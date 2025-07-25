import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}_form_state.dart';

part '{{singular.snakeCase()}}_form_controller.g.dart';

@riverpod
class {{singular.pascalCase()}}FormController extends _${{singular.pascalCase()}}FormController {
  @override
  Future<{{singular.pascalCase()}}FormState> build(String? id) async {
    final {{singular.camelCase()}}Repo = ref.read({{singular.camelCase()}}RepositoryProvider);
    final result = await TaskResult.Do(($) async {
      if (id == null) {
        return {{singular.pascalCase()}}FormState({{singular.camelCase()}}: null);
      }
      final {{singular.camelCase()}} = await $({{singular.camelCase()}}Repo.get(id));
      return {{singular.pascalCase()}}FormState({{singular.camelCase()}}: {{singular.camelCase()}});
    }).run();

    return result.fold(Future.error, (x) => Future.value(x));
  }
}
