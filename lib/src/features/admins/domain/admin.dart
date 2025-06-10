
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mason_sampler/src/core/models/pb_record.dart';

part 'admin.mapper.dart';

@MappableClass()
class Admin extends PbRecord with AdminMappable {

  Admin({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return AdminMapper.fromMap({...raw});
  }

  static const fromJson = AdminMapper.fromJson;
}
