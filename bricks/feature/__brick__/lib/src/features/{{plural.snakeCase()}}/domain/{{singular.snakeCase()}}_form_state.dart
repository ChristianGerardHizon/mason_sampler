import 'package:{{packageName.snakeCase()}}/src/features/{{plural.snakeCase()}}/domain/{{singular.snakeCase()}}.dart';

class {{singular.pascalCase()}}FormState {
  final {{singular.pascalCase()}}? {{singular.camelCase()}};

  {{singular.pascalCase()}}FormState({required this.{{singular.camelCase()}}});
}