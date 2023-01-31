// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListFriendModel _$ListFriendModelFromJson(Map<String, dynamic> json) =>
    ListFriendModel(
      id: json['id'] as String? ?? "",
      createdAt: json['createdAt'] as String? ?? "",
      imageAvatarUrl:
          json['imageAvatarUrl'] as String? ?? AppImages.icFacebookLogo,
      name: json['name'] as String? ?? "",
      shortDescription: json['shortDescription'] as String? ?? "",
      isActive: json['isActive'] as bool? ?? false,
      stories: (json['stories'] as List<dynamic>?)
              ?.map((e) => StoryModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      partner: json['partner'] == null
          ? null
          : PartnerModel.fromJson(json['partner'] as Map<String, dynamic>),
      lastMessage: json['lastMessage'] == null
          ? null
          : LastMessageModel.fromJson(
              json['lastMessage'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ListFriendModelToJson(ListFriendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageAvatarUrl': instance.imageAvatarUrl,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'createdAt': instance.createdAt,
      'isActive': instance.isActive,
      'stories': instance.stories,
      'partner': instance.partner,
      'lastMessage': instance.lastMessage,
    };

LastMessageModel _$LastMessageModelFromJson(Map<String, dynamic> json) =>
    LastMessageModel(
      message: json['message'] as String? ?? "",
      created: json['created'] as String? ?? "",
      unread: json['unread'] as String? ?? "",
    );

Map<String, dynamic> _$LastMessageModelToJson(LastMessageModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'created': instance.created,
      'unread': instance.unread,
    };

PartnerModel _$PartnerModelFromJson(Map<String, dynamic> json) => PartnerModel(
      id: json['id'] as String? ?? "",
      username: json['username'] as String? ?? "User",
      avatar: json['avatar'] as String? ?? AppImages.icRoundFacebookLogo,
    );

Map<String, dynamic> _$PartnerModelToJson(PartnerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
    };

ListConversationResponse _$ListConversationResponseFromJson(
        Map<String, dynamic> json) =>
    ListConversationResponse(
      code: json['code'] as String? ?? "",
      message: json['message'] as String? ?? "",
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => ListFriendModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      numNewMessage: json['numNewMessage'] as int? ?? 0,
    );

Map<String, dynamic> _$ListConversationResponseToJson(
        ListConversationResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
      'numNewMessage': instance.numNewMessage,
    };
