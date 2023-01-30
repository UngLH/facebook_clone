// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageEntity _$ImageEntityFromJson(Map<String, dynamic> json) => ImageEntity(
      id: json['id'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ImageEntityToJson(ImageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
    };

VideoEntity _$VideoEntityFromJson(Map<String, dynamic> json) => VideoEntity(
      thumb: json['thumb'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$VideoEntityToJson(VideoEntity instance) =>
    <String, dynamic>{
      'thumb': instance.thumb,
      'url': instance.url,
    };
