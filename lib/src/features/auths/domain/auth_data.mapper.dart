// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_data.dart';

class AuthDataTypeMapper extends EnumMapper<AuthDataType> {
  AuthDataTypeMapper._();

  static AuthDataTypeMapper? _instance;
  static AuthDataTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthDataTypeMapper._());
    }
    return _instance!;
  }

  static AuthDataType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  AuthDataType decode(dynamic value) {
    switch (value) {
      case r'users':
        return AuthDataType.users;
      case r'admins':
        return AuthDataType.admins;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(AuthDataType self) {
    switch (self) {
      case AuthDataType.users:
        return r'users';
      case AuthDataType.admins:
        return r'admins';
    }
  }
}

extension AuthDataTypeMapperExtension on AuthDataType {
  String toValue() {
    AuthDataTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<AuthDataType>(this) as String;
  }
}

class AuthDataMapper extends ClassMapperBase<AuthData> {
  AuthDataMapper._();

  static AuthDataMapper? _instance;
  static AuthDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthData';

  static String _$id(AuthData v) => v.id;
  static const Field<AuthData, String> _f$id = Field('id', _$id);
  static String _$collectionId(AuthData v) => v.collectionId;
  static const Field<AuthData, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(AuthData v) => v.collectionName;
  static const Field<AuthData, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$token(AuthData v) => v.token;
  static const Field<AuthData, String> _f$token = Field('token', _$token);

  @override
  final MappableFields<AuthData> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #token: _f$token,
  };

  static AuthData _instantiate(DecodingData data) {
    return AuthData(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        token: data.dec(_f$token));
  }

  @override
  final Function instantiate = _instantiate;

  static AuthData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthData>(map);
  }

  static AuthData fromJson(String json) {
    return ensureInitialized().decodeJson<AuthData>(json);
  }
}

mixin AuthDataMappable {
  String toJson() {
    return AuthDataMapper.ensureInitialized()
        .encodeJson<AuthData>(this as AuthData);
  }

  Map<String, dynamic> toMap() {
    return AuthDataMapper.ensureInitialized()
        .encodeMap<AuthData>(this as AuthData);
  }

  AuthDataCopyWith<AuthData, AuthData, AuthData> get copyWith =>
      _AuthDataCopyWithImpl<AuthData, AuthData>(
          this as AuthData, $identity, $identity);
  @override
  String toString() {
    return AuthDataMapper.ensureInitialized().stringifyValue(this as AuthData);
  }

  @override
  bool operator ==(Object other) {
    return AuthDataMapper.ensureInitialized()
        .equalsValue(this as AuthData, other);
  }

  @override
  int get hashCode {
    return AuthDataMapper.ensureInitialized().hashValue(this as AuthData);
  }
}

extension AuthDataValueCopy<$R, $Out> on ObjectCopyWith<$R, AuthData, $Out> {
  AuthDataCopyWith<$R, AuthData, $Out> get $asAuthData =>
      $base.as((v, t, t2) => _AuthDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthDataCopyWith<$R, $In extends AuthData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? token});
  AuthDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AuthDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthData, $Out>
    implements AuthDataCopyWith<$R, AuthData, $Out> {
  _AuthDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthData> $mapper =
      AuthDataMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? token}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (token != null) #token: token
      }));
  @override
  AuthData $make(CopyWithData data) => AuthData(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      token: data.get(#token, or: $value.token));

  @override
  AuthDataCopyWith<$R2, AuthData, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _AuthDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}
