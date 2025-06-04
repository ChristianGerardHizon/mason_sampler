
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mason_sampler/src/core/models/pb_record.dart';

part 'branch.mapper.dart';

@MappableClass()
class Branch extends PbRecord with BranchMappable {

  Branch({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return BranchMapper.fromMap({...raw});
  }

  static const fromJson = BranchMapper.fromJson;
}
