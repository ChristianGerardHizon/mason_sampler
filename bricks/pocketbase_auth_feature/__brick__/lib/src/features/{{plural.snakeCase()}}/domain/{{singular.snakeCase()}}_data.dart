import 'package:dart_mappable/dart_mappable.dart';

part '{{singular.snakeCase()}}_data.mapper.dart';

@MappableEnum()
enum {{singular.pascalCase()}}DataType { {{childPlural.snakeCase()}}, {{parentPlural.snakeCase()}} }

@MappableClass()
class {{singular.pascalCase()}}Data with {{singular.pascalCase()}}DataMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String token;

  {{singular.pascalCase()}}Data({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.token,
  });

  static fromMap(Map<String, dynamic> raw) {
    return {{singular.pascalCase()}}DataMapper.fromMap({
      ...raw,
      'id': raw['record']['id'],
      'collectionId': raw['record']['collectionId'],
    });
  }

  /// get type
  /// 
  {{singular.pascalCase()}}DataType get type {
    if (collectionName == '{{childPlural.snakeCase()}}') {
      return {{singular.pascalCase()}}DataType.{{childPlural.snakeCase()}};
    } else if (collectionName == '{{parentPlural.snakeCase()}}') {
      return {{singular.pascalCase()}}DataType.{{parentPlural.snakeCase()}};
    }
    throw 'unknown collection name ($collectionName)';
  }


  static const fromJson = {{singular.pascalCase()}}DataMapper.fromJson;
}
