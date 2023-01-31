import 'package:facebook/models/entities/post/post_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'search_entity.g.dart';

@JsonSerializable()
class SearchEntity {
  String? id;
  String? keyword;
  String? created;

  SearchEntity({this.id, this.keyword, this.created});

  SearchEntity copyWith({String? id, String? keyword, String? created}) {
    return SearchEntity(
        id: id ?? this.id,
        keyword: keyword ?? keyword,
        created: created ?? this.created);
  }

  factory SearchEntity.fromJson(Map<String, dynamic> json) =>
      _$SearchEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SearchEntityToJson(this);
}

@JsonSerializable()
class SavedSearchResponse {
  String? code;
  String? message;
  @JsonKey(name: "data")
  List<SearchEntity>? data;

  SavedSearchResponse({this.code, this.message, this.data});

  SavedSearchResponse copyWith(
      {String? code, String? message, List<SearchEntity>? data}) {
    return SavedSearchResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory SavedSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SavedSearchResponseToJson(this);
}
