// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_friend_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ListFriendModel _$ListFriendModelFromJson(Map<String, dynamic> json) =>
    ListFriendModel(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      imageAvatarUrl: json['imageAvatarUrl'] as String?,
      name: json['name'] as String?,
      shortDescription: json['shortDescription'] as String?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$ListFriendModelToJson(ListFriendModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageAvatarUrl': instance.imageAvatarUrl,
      'name': instance.name,
      'shortDescription': instance.shortDescription,
      'createdAt': instance.createdAt,
      'isActive': instance.isActive,
    };
