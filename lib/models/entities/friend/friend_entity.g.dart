// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendSuggestEntity _$FriendSuggestEntityFromJson(Map<String, dynamic> json) =>
    FriendSuggestEntity(
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      sameFriend: json['same_friends'] as String?,
    );

Map<String, dynamic> _$FriendSuggestEntityToJson(
        FriendSuggestEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'username': instance.username,
      'avatar': instance.avatar,
      'same_friends': instance.sameFriend,
    };

FriendDataResponse _$FriendDataResponseFromJson(Map<String, dynamic> json) =>
    FriendDataResponse(
      total: json['total'] as String?,
      listUsers: (json['list_users'] as List<dynamic>?)
          ?.map((e) => FriendSuggestEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FriendDataResponseToJson(FriendDataResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'list_users': instance.listUsers,
    };

FriendSuggestResponse _$FriendSuggestResponseFromJson(
        Map<String, dynamic> json) =>
    FriendSuggestResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : FriendDataResponse.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FriendSuggestResponseToJson(
        FriendSuggestResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

FriendEntity _$FriendEntityFromJson(Map<String, dynamic> json) => FriendEntity(
      userId: json['id'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      sameFriend: json['same_friends'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$FriendEntityToJson(FriendEntity instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'username': instance.username,
      'avatar': instance.avatar,
      'same_friends': instance.sameFriend,
      'created': instance.created,
    };

FriendRequestDataResponse _$FriendRequestDataResponseFromJson(
        Map<String, dynamic> json) =>
    FriendRequestDataResponse(
      listUsers: (json['list_user'] as List<dynamic>?)
          ?.map((e) => FriendEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as String?,
    );

Map<String, dynamic> _$FriendRequestDataResponseToJson(
        FriendRequestDataResponse instance) =>
    <String, dynamic>{
      'list_user': instance.listUsers,
      'total': instance.total,
    };
