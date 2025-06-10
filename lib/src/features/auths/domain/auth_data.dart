import 'package:dart_mappable/dart_mappable.dart';

part 'auth_data.mapper.dart';

@MappableEnum()
enum AuthDataType { users, admins }

@MappableClass()
class AuthData with AuthDataMappable {
  final String id;
  final String collectionId;
  final String collectionName;
  final String token;

  AuthData({
    required this.id,
    required this.collectionId,
    required this.collectionName,
    required this.token,
  });

  static fromMap(Map<String, dynamic> raw) {
    return AuthDataMapper.fromMap({
      ...raw,
      'id': raw['record']['id'],
      'collectionId': raw['record']['collectionId'],
    });
  }

  /// get type
  /// 
  AuthDataType get type {
    if (collectionName == 'users') {
      return AuthDataType.users;
    } else if (collectionName == 'admins') {
      return AuthDataType.admins;
    }
    throw 'unknown collection name ($collectionName)';
  }


  static const fromJson = AuthDataMapper.fromJson;
}
