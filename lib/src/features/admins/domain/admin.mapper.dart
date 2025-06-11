// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'admin.dart';

class AdminMapper extends ClassMapperBase<Admin> {
  AdminMapper._();

  static AdminMapper? _instance;
  static AdminMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AdminMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Admin';

  static String _$id(Admin v) => v.id;
  static const Field<Admin, String> _f$id = Field('id', _$id);
  static String _$collectionId(Admin v) => v.collectionId;
  static const Field<Admin, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(Admin v) => v.collectionName;
  static const Field<Admin, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(Admin v) => v.isDeleted;
  static const Field<Admin, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(Admin v) => v.created;
  static const Field<Admin, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Admin v) => v.updated;
  static const Field<Admin, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<Admin> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Admin _instantiate(DecodingData data) {
    return Admin(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Admin fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Admin>(map);
  }

  static Admin fromJson(String json) {
    return ensureInitialized().decodeJson<Admin>(json);
  }
}

mixin AdminMappable {
  String toJson() {
    return AdminMapper.ensureInitialized().encodeJson<Admin>(this as Admin);
  }

  Map<String, dynamic> toMap() {
    return AdminMapper.ensureInitialized().encodeMap<Admin>(this as Admin);
  }

  AdminCopyWith<Admin, Admin, Admin> get copyWith =>
      _AdminCopyWithImpl<Admin, Admin>(this as Admin, $identity, $identity);
  @override
  String toString() {
    return AdminMapper.ensureInitialized().stringifyValue(this as Admin);
  }

  @override
  bool operator ==(Object other) {
    return AdminMapper.ensureInitialized().equalsValue(this as Admin, other);
  }

  @override
  int get hashCode {
    return AdminMapper.ensureInitialized().hashValue(this as Admin);
  }
}

extension AdminValueCopy<$R, $Out> on ObjectCopyWith<$R, Admin, $Out> {
  AdminCopyWith<$R, Admin, $Out> get $asAdmin =>
      $base.as((v, t, t2) => _AdminCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AdminCopyWith<$R, $In extends Admin, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  AdminCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AdminCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Admin, $Out>
    implements AdminCopyWith<$R, Admin, $Out> {
  _AdminCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Admin> $mapper = AdminMapper.ensureInitialized();
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
  Admin $make(CopyWithData data) => Admin(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  AdminCopyWith<$R2, Admin, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _AdminCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
