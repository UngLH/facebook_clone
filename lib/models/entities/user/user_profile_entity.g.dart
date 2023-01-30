// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfileEntity _$UserProfileEntityFromJson(Map<String, dynamic> json) =>
    UserProfileEntity(
      id: json['id'] as String?,
      username: json['username'] as String?,
      created: json['created'] as String?,
      description: json['description'] as String?,
      avatar: json['avatar'] as String?,
      address: json['address'] as String?,
      coverImage: json['cover_image'] as String?,
      link: json['link'] as String?,
      country: json['country'] as String?,
      city: json['city'] as String?,
      listing: json['listing'] as String?,
      isFriend: json['is_friend'] as String?,
      online: json['online'] as String?,
    );

Map<String, dynamic> _$UserProfileEntityToJson(UserProfileEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'created': instance.created,
      'description': instance.description,
      'avatar': instance.avatar,
      'cover_image': instance.coverImage,
      'listing': instance.listing,
      'link': instance.link,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'is_friend': instance.isFriend,
      'online': instance.online,
    };

ProfileResponse _$ProfileResponseFromJson(Map<String, dynamic> json) =>
    ProfileResponse(
      message: json['message'] as String?,
      code: json['code'] as String?,
      data: json['data'] == null
          ? null
          : UserProfileEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProfileResponseToJson(ProfileResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
