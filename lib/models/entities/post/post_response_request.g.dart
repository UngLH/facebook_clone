// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DataResponseEntity _$DataResponseEntityFromJson(Map<String, dynamic> json) =>
    DataResponseEntity(
      posts: (json['posts'] as List<dynamic>?)
          ?.map((e) => PostResponseEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      newItems: json['new_items'] as String?,
      lastId: json['last_id'] as String?,
    );

Map<String, dynamic> _$DataResponseEntityToJson(DataResponseEntity instance) =>
    <String, dynamic>{
      'posts': instance.posts,
      'new_items': instance.newItems,
      'last_id': instance.lastId,
    };

PostResponseRequest _$PostResponseRequestFromJson(Map<String, dynamic> json) =>
    PostResponseRequest(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : DataResponseEntity.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostResponseRequestToJson(
        PostResponseRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
