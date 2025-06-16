class {{singular.pascalCase()}}TableKey {
  static String _tableKey = '{{singular.snakeCase()}}_table_key';

  static String key({String? id}) {
    if (id == null) {
      return _tableKey;
    }

    return '${_tableKey}_$id';
  }
}