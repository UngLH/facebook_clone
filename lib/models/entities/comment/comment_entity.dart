import 'package:facebook/models/entities/author/author_entity.dart';
import 'package:facebook/models/entities/media/image_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment_entity.g.dart';

@JsonSerializable()
class CommentEntity {
  String? id;
  String? comment;
  String? created;
  @JsonKey(name: "poster")
  AuthorEntity? authorEntity;
  @JsonKey(name: "is_blocked")
  String? isBlocked;

  CommentEntity(
      {this.id, this.created, this.comment, this.isBlocked, this.authorEntity});

  CommentEntity copyWith(
      {String? id,
      String? created,
      String? comment,
      String? isBlocked,
      AuthorEntity? authorEntity}) {
    return CommentEntity(
        id: id ?? this.id,
        created: created ?? this.created,
        comment: comment ?? this.comment,
        isBlocked: isBlocked ?? this.isBlocked,
        authorEntity: authorEntity ?? this.authorEntity);
  }

  factory CommentEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommentEntityToJson(this);
}

@JsonSerializable()
class CommentResponseEntity {
  String? code;
  String? message;
  List<CommentEntity>? data;

  CommentResponseEntity({this.code, this.message, this.data});

  CommentResponseEntity copyWith(
      {String? code, String? message, List<CommentEntity>? data}) {
    return CommentResponseEntity(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory CommentResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$CommentResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$CommentResponseEntityToJson(this);
}
