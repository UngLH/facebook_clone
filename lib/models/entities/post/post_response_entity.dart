import 'package:facebook/models/entities/author/author_entity.dart';
import 'package:facebook/models/entities/media/image_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_response_entity.g.dart';

@JsonSerializable()
class PostResponseEntity {
  String? id;
  @JsonKey(name: "image")
  List<ImageEntity>? images;
  @JsonKey(name: "video")
  VideoEntity? video;
  String? described;
  String? created;
  String? modified;
  String? like;
  String? comment;
  @JsonKey(name: "is_liked")
  String? isLiked;
  @JsonKey(name: "is_blocked")
  String? isBlocked;
  @JsonKey(name: "can_comment")
  String? canComment;
  @JsonKey(name: "can_edit")
  String? canEdit;
  String? state;
  @JsonKey(name: "author")
  AuthorEntity? authorEntity;

  PostResponseEntity(
      {this.id,
      this.images,
      this.video,
      this.described,
      this.created,
      this.modified,
      this.like,
      this.comment,
      this.isLiked,
      this.isBlocked,
      this.canEdit,
      this.canComment,
      this.authorEntity,
      this.state});

  PostResponseEntity copyWith(
      {String? id,
      List<ImageEntity>? images,
      VideoEntity? video,
      String? described,
      String? created,
      String? modified,
      String? like,
      String? comment,
      String? isLiked,
      String? isBlocked,
      String? canComment,
      String? canEdit,
      String? state,
      AuthorEntity? authorEntity}) {
    return PostResponseEntity(
        id: id ?? this.id,
        images: images ?? this.images,
        video: video ?? this.video,
        described: described ?? this.described,
        created: created ?? this.created,
        modified: modified ?? this.modified,
        like: like ?? this.like,
        comment: comment ?? this.comment,
        isLiked: isLiked ?? this.isLiked,
        isBlocked: isBlocked ?? this.isBlocked,
        canComment: canComment ?? this.canComment,
        canEdit: canEdit ?? this.canEdit,
        state: state ?? this.state,
        authorEntity: authorEntity ?? this.authorEntity);
  }

  factory PostResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$PostResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseEntityToJson(this);
}
