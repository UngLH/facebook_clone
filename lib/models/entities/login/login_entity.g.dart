// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginEntity _$LoginEntityFromJson(Map<String, dynamic> json) => LoginEntity(
      id: json['id'] as String?,
      username: json['username'] as String?,
      token: json['token'] as String?,
      avatar: json['avatar'] as String?,
      active: json['active'] as String?,
    );

Map<String, dynamic> _$LoginEntityToJson(LoginEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'token': instance.token,
      'avatar': instance.avatar,
      'active': instance.active,
    };
