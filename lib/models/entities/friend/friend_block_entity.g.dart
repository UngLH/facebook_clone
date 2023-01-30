// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_block_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendBlockEntity _$FriendBlockEntityFromJson(Map<String, dynamic> json) =>
    FriendBlockEntity(
      userId: json['id'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$FriendBlockEntityToJson(FriendBlockEntity instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'username': instance.username,
      'avatar': instance.avatar,
    };

ListBlockResponse _$ListBlockResponseFromJson(Map<String, dynamic> json) =>
    ListBlockResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => FriendBlockEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ListBlockResponseToJson(ListBlockResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
