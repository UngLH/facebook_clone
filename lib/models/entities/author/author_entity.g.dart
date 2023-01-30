// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorEntity _$AuthorEntityFromJson(Map<String, dynamic> json) => AuthorEntity(
      id: json['id'] as String?,
      username: json['username'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$AuthorEntityToJson(AuthorEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatar': instance.avatar,
    };

CommentAuthorEntity _$CommentAuthorEntityFromJson(Map<String, dynamic> json) =>
    CommentAuthorEntity(
      id: json['id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$CommentAuthorEntityToJson(
        CommentAuthorEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };
