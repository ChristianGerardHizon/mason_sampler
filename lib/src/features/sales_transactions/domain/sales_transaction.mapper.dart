// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'sales_transaction.dart';

class SalesTransactionMapper extends ClassMapperBase<SalesTransaction> {
  SalesTransactionMapper._();

  static SalesTransactionMapper? _instance;
  static SalesTransactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SalesTransactionMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SalesTransaction';

  static String _$id(SalesTransaction v) => v.id;
  static const Field<SalesTransaction, String> _f$id = Field('id', _$id);
  static String _$collectionId(SalesTransaction v) => v.collectionId;
  static const Field<SalesTransaction, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(SalesTransaction v) => v.collectionName;
  static const Field<SalesTransaction, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(SalesTransaction v) => v.isDeleted;
  static const Field<SalesTransaction, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(SalesTransaction v) => v.created;
  static const Field<SalesTransaction, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(SalesTransaction v) => v.updated;
  static const Field<SalesTransaction, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<SalesTransaction> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static SalesTransaction _instantiate(DecodingData data) {
    return SalesTransaction(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static SalesTransaction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SalesTransaction>(map);
  }

  static SalesTransaction fromJson(String json) {
    return ensureInitialized().decodeJson<SalesTransaction>(json);
  }
}

mixin SalesTransactionMappable {
  String toJson() {
    return SalesTransactionMapper.ensureInitialized()
        .encodeJson<SalesTransaction>(this as SalesTransaction);
  }

  Map<String, dynamic> toMap() {
    return SalesTransactionMapper.ensureInitialized()
        .encodeMap<SalesTransaction>(this as SalesTransaction);
  }

  SalesTransactionCopyWith<SalesTransaction, SalesTransaction, SalesTransaction>
      get copyWith =>
          _SalesTransactionCopyWithImpl<SalesTransaction, SalesTransaction>(
              this as SalesTransaction, $identity, $identity);
  @override
  String toString() {
    return SalesTransactionMapper.ensureInitialized()
        .stringifyValue(this as SalesTransaction);
  }

  @override
  bool operator ==(Object other) {
    return SalesTransactionMapper.ensureInitialized()
        .equalsValue(this as SalesTransaction, other);
  }

  @override
  int get hashCode {
    return SalesTransactionMapper.ensureInitialized()
        .hashValue(this as SalesTransaction);
  }
}

extension SalesTransactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SalesTransaction, $Out> {
  SalesTransactionCopyWith<$R, SalesTransaction, $Out>
      get $asSalesTransaction => $base
          .as((v, t, t2) => _SalesTransactionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SalesTransactionCopyWith<$R, $In extends SalesTransaction, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  SalesTransactionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _SalesTransactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SalesTransaction, $Out>
    implements SalesTransactionCopyWith<$R, SalesTransaction, $Out> {
  _SalesTransactionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SalesTransaction> $mapper =
      SalesTransactionMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  SalesTransaction $make(CopyWithData data) => SalesTransaction(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  SalesTransactionCopyWith<$R2, SalesTransaction, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _SalesTransactionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
