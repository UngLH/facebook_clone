// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Popular _$PopularFromJson(Map<String, dynamic> json) => Popular(
      id: json['id'] as int?,
      imgUrl: json['imgUrl'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      note: json['note'] as String?,
    );

Map<String, dynamic> _$PopularToJson(Popular instance) => <String, dynamic>{
      'id': instance.id,
      'imgUrl': instance.imgUrl,
      'title': instance.title,
      'description': instance.description,
      'note': instance.note,
    };
