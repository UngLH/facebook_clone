import 'package:facebook/models/entities/author/author_entity.dart';
import 'package:facebook/models/entities/media/image_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'post_search_entity.g.dart';

@JsonSerializable()
class PostSearchEntity {
  String? id;
  List<String>? image;
  VideoEntity? video;
  String? like;
  String? comment;
  @JsonKey(name: "is_liked")
  String? isLiked;
  AuthorEntity? author;
  String? described;

  PostSearchEntity(
      {this.id,
      this.image,
      this.video,
      this.like,
      this.comment,
      this.isLiked,
      this.author,
      this.described});

  PostSearchEntity copyWith(
      {String? id,
      List<String>? image,
      VideoEntity? video,
      String? like,
      String? comment,
      String? isLiked,
      AuthorEntity? author,
      String? described}) {
    return PostSearchEntity(
        id: id ?? this.id,
        image: image ?? this.image,
        like: like ?? this.like,
        comment: comment ?? this.comment,
        isLiked: isLiked ?? this.isLiked,
        author: author ?? this.author,
        described: described ?? this.described);
  }

  factory PostSearchEntity.fromJson(Map<String, dynamic> json) =>
      _$PostSearchEntityFromJson(json);

  Map<String, dynamic> toJson() => _$PostSearchEntityToJson(this);
}

@JsonSerializable()
class PostSearchResponse {
  String? code;
  String? message;
  @JsonKey(name: "data")
  List<PostSearchEntity>? data;

  PostSearchResponse({this.code, this.message, this.data});

  PostSearchResponse copyWith(
      {String? code, String? message, List<PostSearchEntity>? data}) {
    return PostSearchResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory PostSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$PostSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PostSearchResponseToJson(this);
}
