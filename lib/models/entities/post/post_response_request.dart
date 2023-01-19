import 'package:facebook/models/entities/post/post_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post_response_request.g.dart';

@JsonSerializable()
class DataResponseEntity {
  List<PostResponseEntity>? posts;
  @JsonKey(name: "new_items")
  String? newItems;
  @JsonKey(name: "last_id")
  String? lastId;

  DataResponseEntity({this.posts, this.newItems, this.lastId});

  DataResponseEntity copyWith(
      {List<PostResponseEntity>? posts, String? newItems, String? lastId}) {
    return DataResponseEntity();
  }

  factory DataResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$DataResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$DataResponseEntityToJson(this);
}

@JsonSerializable()
class PostResponseRequest {
  String? code;
  String? message;
  @JsonKey(name: "data")
  DataResponseEntity? data;

  PostResponseRequest({this.code, this.message, this.data});

  PostResponseRequest copyWith(
      {String? code, String? message, DataResponseEntity? data}) {
    return PostResponseRequest();
  }

  factory PostResponseRequest.fromJson(Map<String, dynamic> json) =>
      _$PostResponseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PostResponseRequestToJson(this);
}
