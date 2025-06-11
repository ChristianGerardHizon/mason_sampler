import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// system import
import 'package:{{packageName.snakeCase()}}/src/core/models/fields/pb_field.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/failure.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/page_results.dart';
import 'package:{{packageName.snakeCase()}}/src/core/models/type_defs.dart';


part '{{singular.snakeCase()}}_repository.g.dart';

@Riverpod(keepAlive: true)
{{singular.pascalCase()}}Repository {{singular.camelCase()}}Repository(Ref ref) {
  return {{singular.pascalCase()}}RepositoryImpl();
}

class {{singular.pascalCase()}}Repository {
  ///
  /// Fetches a list of [{{singular.pascalCase()}}]s from the server.
  ///
}

class {{singular.pascalCase()}}RepositoryImpl extends {{singular.pascalCase()}}Repository {
  
}
