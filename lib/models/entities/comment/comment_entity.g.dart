// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentEntity _$CommentEntityFromJson(Map<String, dynamic> json) =>
    CommentEntity(
      id: json['id'] as String?,
      created: json['created'] as String?,
      comment: json['comment'] as String?,
      isBlocked: json['is_blocked'] as String?,
      authorEntity: json['poster'] == null
          ? null
          : AuthorEntity.fromJson(json['poster'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentEntityToJson(CommentEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'created': instance.created,
      'poster': instance.authorEntity,
      'is_blocked': instance.isBlocked,
    };

CommentResponseEntity _$CommentResponseEntityFromJson(
        Map<String, dynamic> json) =>
    CommentResponseEntity(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => CommentEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CommentResponseEntityToJson(
        CommentResponseEntity instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
