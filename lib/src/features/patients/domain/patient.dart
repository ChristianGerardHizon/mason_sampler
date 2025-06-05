
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mason_sampler/src/core/models/pb_record.dart';

part 'patient.mapper.dart';

@MappableClass()
class Patient extends PbRecord with PatientMappable {

  Patient({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return PatientMapper.fromMap({...raw});
  }

  static const fromJson = PatientMapper.fromJson;
}
