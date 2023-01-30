// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendRequestEntity _$FriendRequestEntityFromJson(Map<String, dynamic> json) =>
    FriendRequestEntity(
      userId: json['id'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
      sameFriend: json['same_friends'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$FriendRequestEntityToJson(
        FriendRequestEntity instance) =>
    <String, dynamic>{
      'id': instance.userId,
      'username': instance.username,
      'avatar': instance.avatar,
      'same_friends': instance.sameFriend,
      'created': instance.created,
    };

RequestData _$RequestDataFromJson(Map<String, dynamic> json) => RequestData(
      requestList: (json['request'] as List<dynamic>?)
          ?.map((e) => FriendRequestEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as String?,
    );

Map<String, dynamic> _$RequestDataToJson(RequestData instance) =>
    <String, dynamic>{
      'request': instance.requestList,
      'total': instance.total,
    };

RequestFriendResponse _$RequestFriendResponseFromJson(
        Map<String, dynamic> json) =>
    RequestFriendResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : RequestData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RequestFriendResponseToJson(
        RequestFriendResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
