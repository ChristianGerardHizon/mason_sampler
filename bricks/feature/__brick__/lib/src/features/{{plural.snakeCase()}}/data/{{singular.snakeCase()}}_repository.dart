import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// system import
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/page_results.dart';

part '{{singular.snakeCase()}}_repository.g.dart';

@Riverpod(keepAlive: true)
{{singular.pascalCase()}}Repository {{singular.camelCase()}}Repository(Ref ref) {
  return {{singular.pascalCase()}}RepositoryImpl();
}

abstract class {{singular.pascalCase()}}Repository {
  /// get
  TaskResult<{{singular.pascalCase()}}> get(String id);

  /// update
  TaskResult<{{singular.pascalCase()}}> update(
    {{singular.pascalCase()}} {{singular.camelCase()}},
    Map<String, dynamic> update,
  );

  /// delete
  TaskResult<void> delete(List<String> ids);

  /// list
  TaskResult<PageResults<{{singular.pascalCase()}}>> list({int pageNo = 0, int pageSize = 0});
}

class {{singular.pascalCase()}}RepositoryImpl extends {{singular.pascalCase()}}Repository {
  @override
  TaskResult<void> delete(List<String> ids) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  TaskResult<{{singular.pascalCase()}}> get(String id) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  TaskResult<PageResults<{{singular.pascalCase()}}>> list({int pageNo = 0, int pageSize = 0}) {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  TaskResult<{{singular.pascalCase()}}> update(
    {{singular.pascalCase()}} {{singular.camelCase()}},
    Map<String, dynamic> update,
  ) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
