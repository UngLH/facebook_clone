// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_response_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostResponseEntity _$PostResponseEntityFromJson(Map<String, dynamic> json) =>
    PostResponseEntity(
      id: json['id'] as String?,
      images: (json['image'] as List<dynamic>?)
          ?.map((e) => ImageEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
      video: json['video'] == null
          ? null
          : VideoEntity.fromJson(json['video'] as Map<String, dynamic>),
      described: json['described'] as String?,
      created: json['created'] as String?,
      modified: json['modified'] as String?,
      like: json['like'] as String?,
      comment: json['comment'] as String?,
      isLiked: json['is_liked'] as String?,
      isBlocked: json['is_blocked'] as String?,
      canEdit: json['can_edit'] as String?,
      canComment: json['can_comment'] as String?,
      authorEntity: json['author'] == null
          ? null
          : AuthorEntity.fromJson(json['author'] as Map<String, dynamic>),
      state: json['state'] as String?,
    );

Map<String, dynamic> _$PostResponseEntityToJson(PostResponseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.images,
      'video': instance.video,
      'described': instance.described,
      'created': instance.created,
      'modified': instance.modified,
      'like': instance.like,
      'comment': instance.comment,
      'is_liked': instance.isLiked,
      'is_blocked': instance.isBlocked,
      'can_comment': instance.canComment,
      'can_edit': instance.canEdit,
      'state': instance.state,
      'author': instance.authorEntity,
    };
