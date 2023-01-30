// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoryModel _$StoryModelFromJson(Map<String, dynamic> json) => StoryModel(
      id: json['_id'] as String?,
      text: json['text'] as String?,
      imageUrl: json['imageUrl'] as String?,
    );

Map<String, dynamic> _$StoryModelToJson(StoryModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'text': instance.text,
      'imageUrl': instance.imageUrl,
    };
