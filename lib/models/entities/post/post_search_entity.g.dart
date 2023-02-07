// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_search_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostSearchEntity _$PostSearchEntityFromJson(Map<String, dynamic> json) =>
    PostSearchEntity(
      id: json['id'] as String?,
      image:
          (json['image'] as List<dynamic>?)?.map((e) => e as String).toList(),
      video: json['video'] == null
          ? null
          : VideoEntity.fromJson(json['video'] as Map<String, dynamic>),
      like: json['like'] as String?,
      comment: json['comment'] as String?,
      isLiked: json['is_liked'] as String?,
      author: json['author'] == null
          ? null
          : AuthorEntity.fromJson(json['author'] as Map<String, dynamic>),
      described: json['described'] as String?,
    );

Map<String, dynamic> _$PostSearchEntityToJson(PostSearchEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'video': instance.video,
      'like': instance.like,
      'comment': instance.comment,
      'is_liked': instance.isLiked,
      'author': instance.author,
      'described': instance.described,
    };

PostSearchResponse _$PostSearchResponseFromJson(Map<String, dynamic> json) =>
    PostSearchResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PostSearchEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PostSearchResponseToJson(PostSearchResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
