
import 'package:dart_mappable/dart_mappable.dart';

part '{{singular.snakeCase()}}.mapper.dart';

@MappableClass()
class {{singular.pascalCase()}} with {{singular.pascalCase()}}Mappable {

  {{singular.pascalCase()}}({
    required this.id,
  });

  final String id;

  static fromMap(Map<String, dynamic> raw) {
    return {{singular.pascalCase()}}Mapper.fromMap({...raw});
  }

  static const fromJson = {{singular.pascalCase()}}Mapper.fromJson;
}
