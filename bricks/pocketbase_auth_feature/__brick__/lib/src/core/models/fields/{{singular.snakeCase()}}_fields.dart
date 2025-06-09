import 'package:{{packageName.snakeCase()}}/src/core/models/fields/pb_field.dart';

class {{singular.pascalCase()}}Fields {
  static const String id = PbField.id;
  static const String created = PbField.created;
  static const String updated = PbField.updated;
  static const String isDeleted = PbField.isDeleted;

  static const String identity = 'identity';
  static const String password = 'password';

  static const String type = 'type';
}