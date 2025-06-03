
import 'package:dart_mappable/dart_mappable.dart';
import 'package:{{pakcageName.snakeCase()}}/src/core/models/pb_record.dart';

part '{{singular.snakeCase()}}.mapper.dart';

@MappableClass()
class {{singular.pascalCase()}} extends PbRecord with {{singular.pascalCase()}}Mappable {

  {{singular.pascalCase()}}({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return {{singular.pascalCase()}}Mapper.fromMap({...raw});
  }

  static const fromJson = {{singular.pascalCase()}}Mapper.fromJson;
}
