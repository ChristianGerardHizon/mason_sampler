import 'package:dart_mappable/dart_mappable.dart';

part '{{singular.snakeCase()}}_data.mapper.dart';

@MappableClass()
class {{singular.pascalCase()}}Data with {{singular.pascalCase()}}DataMappable {
  final String id;
  final String token;

  {{singular.pascalCase()}}Data({
    required this.id,
    required this.token,
  });

  static fromMap(Map<String, dynamic> raw) {
    return {{singular.pascalCase()}}DataMapper.fromMap({
      ...raw,
    });
  }

  static const fromJson = {{singular.pascalCase()}}DataMapper.fromJson;
}
