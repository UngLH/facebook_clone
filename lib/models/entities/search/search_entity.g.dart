// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchEntity _$SearchEntityFromJson(Map<String, dynamic> json) => SearchEntity(
      id: json['id'] as String?,
      keyword: json['keyword'] as String?,
      created: json['created'] as String?,
    );

Map<String, dynamic> _$SearchEntityToJson(SearchEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'keyword': instance.keyword,
      'created': instance.created,
    };

SavedSearchResponse _$SavedSearchResponseFromJson(Map<String, dynamic> json) =>
    SavedSearchResponse(
      code: json['code'] as String?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SearchEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SavedSearchResponseToJson(
        SavedSearchResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
