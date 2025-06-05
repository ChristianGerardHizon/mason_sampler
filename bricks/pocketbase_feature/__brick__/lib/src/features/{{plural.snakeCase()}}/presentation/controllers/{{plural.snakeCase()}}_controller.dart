import 'package:riverpod_annotation/riverpod_annotation.dart';
// system imports
import 'package:{{packageName.snakeCase()}}/src/core/models/fields/pb_field.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/data/{{singular.snakeCase()}}_repository.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';

part '{{plural.snakeCase()}}_controller.g.dart';

@riverpod
class {{plural.pascalCase()}}Controller extends _${{plural.pascalCase()}}Controller {
  @override
  Future<List<{{singular.pascalCase()}}>> build() async {
    final repo = ref.read({{singular.camelCase()}}RepositoryProvider);
    final result = await repo
        .listAll(filter: "${PbField.isDeleted} = false")
        .run();
    return result.fold(Future.error, (x) => Future.value(x));
  }
}
