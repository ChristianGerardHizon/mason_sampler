// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'customer.dart';

class CustomerMapper extends ClassMapperBase<Customer> {
  CustomerMapper._();

  static CustomerMapper? _instance;
  static CustomerMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CustomerMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Customer';

  static String _$id(Customer v) => v.id;
  static const Field<Customer, String> _f$id = Field('id', _$id);
  static String _$collectionId(Customer v) => v.collectionId;
  static const Field<Customer, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(Customer v) => v.collectionName;
  static const Field<Customer, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(Customer v) => v.isDeleted;
  static const Field<Customer, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(Customer v) => v.created;
  static const Field<Customer, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Customer v) => v.updated;
  static const Field<Customer, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<Customer> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Customer _instantiate(DecodingData data) {
    return Customer(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Customer fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Customer>(map);
  }

  static Customer fromJson(String json) {
    return ensureInitialized().decodeJson<Customer>(json);
  }
}

mixin CustomerMappable {
  String toJson() {
    return CustomerMapper.ensureInitialized()
        .encodeJson<Customer>(this as Customer);
  }

  Map<String, dynamic> toMap() {
    return CustomerMapper.ensureInitialized()
        .encodeMap<Customer>(this as Customer);
  }

  CustomerCopyWith<Customer, Customer, Customer> get copyWith =>
      _CustomerCopyWithImpl<Customer, Customer>(
          this as Customer, $identity, $identity);
  @override
  String toString() {
    return CustomerMapper.ensureInitialized().stringifyValue(this as Customer);
  }

  @override
  bool operator ==(Object other) {
    return CustomerMapper.ensureInitialized()
        .equalsValue(this as Customer, other);
  }

  @override
  int get hashCode {
    return CustomerMapper.ensureInitialized().hashValue(this as Customer);
  }
}

extension CustomerValueCopy<$R, $Out> on ObjectCopyWith<$R, Customer, $Out> {
  CustomerCopyWith<$R, Customer, $Out> get $asCustomer =>
      $base.as((v, t, t2) => _CustomerCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CustomerCopyWith<$R, $In extends Customer, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  CustomerCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CustomerCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Customer, $Out>
    implements CustomerCopyWith<$R, Customer, $Out> {
  _CustomerCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Customer> $mapper =
      CustomerMapper.ensureInitialized();
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
  Customer $make(CopyWithData data) => Customer(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  CustomerCopyWith<$R2, Customer, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _CustomerCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
