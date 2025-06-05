
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mason_sampler/src/core/models/pb_record.dart';

part 'customer.mapper.dart';

@MappableClass()
class Customer extends PbRecord with CustomerMappable {

  Customer({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return CustomerMapper.fromMap({...raw});
  }

  static const fromJson = CustomerMapper.fromJson;
}
