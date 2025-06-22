
import 'package:dart_mappable/dart_mappable.dart';
import 'package:mason_sampler/src/core/models/pb_record.dart';

part 'sales_transaction.mapper.dart';

@MappableClass()
class SalesTransaction extends PbRecord with SalesTransactionMappable {

  SalesTransaction({
    required super.id,
    required super.collectionId,
    required super.collectionName,
    super.isDeleted = false,
    super.created,
    super.updated,
  });

  static fromMap(Map<String, dynamic> raw) {
    return SalesTransactionMapper.fromMap({...raw});
  }

  static const fromJson = SalesTransactionMapper.fromJson;
}
