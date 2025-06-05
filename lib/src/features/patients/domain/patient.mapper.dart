// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'patient.dart';

class PatientMapper extends ClassMapperBase<Patient> {
  PatientMapper._();

  static PatientMapper? _instance;
  static PatientMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PatientMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Patient';

  static String _$id(Patient v) => v.id;
  static const Field<Patient, String> _f$id = Field('id', _$id);
  static String _$collectionId(Patient v) => v.collectionId;
  static const Field<Patient, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(Patient v) => v.collectionName;
  static const Field<Patient, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(Patient v) => v.isDeleted;
  static const Field<Patient, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(Patient v) => v.created;
  static const Field<Patient, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(Patient v) => v.updated;
  static const Field<Patient, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<Patient> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Patient _instantiate(DecodingData data) {
    return Patient(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Patient fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Patient>(map);
  }

  static Patient fromJson(String json) {
    return ensureInitialized().decodeJson<Patient>(json);
  }
}

mixin PatientMappable {
  String toJson() {
    return PatientMapper.ensureInitialized()
        .encodeJson<Patient>(this as Patient);
  }

  Map<String, dynamic> toMap() {
    return PatientMapper.ensureInitialized()
        .encodeMap<Patient>(this as Patient);
  }

  PatientCopyWith<Patient, Patient, Patient> get copyWith =>
      _PatientCopyWithImpl<Patient, Patient>(
          this as Patient, $identity, $identity);
  @override
  String toString() {
    return PatientMapper.ensureInitialized().stringifyValue(this as Patient);
  }

  @override
  bool operator ==(Object other) {
    return PatientMapper.ensureInitialized()
        .equalsValue(this as Patient, other);
  }

  @override
  int get hashCode {
    return PatientMapper.ensureInitialized().hashValue(this as Patient);
  }
}

extension PatientValueCopy<$R, $Out> on ObjectCopyWith<$R, Patient, $Out> {
  PatientCopyWith<$R, Patient, $Out> get $asPatient =>
      $base.as((v, t, t2) => _PatientCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PatientCopyWith<$R, $In extends Patient, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  PatientCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PatientCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Patient, $Out>
    implements PatientCopyWith<$R, Patient, $Out> {
  _PatientCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Patient> $mapper =
      PatientMapper.ensureInitialized();
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
  Patient $make(CopyWithData data) => Patient(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  PatientCopyWith<$R2, Patient, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PatientCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
