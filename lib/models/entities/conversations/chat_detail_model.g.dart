// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatDetailModel _$ChatDetailModelFromJson(Map<String, dynamic> json) =>
    ChatDetailModel(
      id: json['id'] as int?,
      createdAt: json['createdAt'] as String?,
      conversation_id: json['conversation_id'] as String?,
      dialog_id: json['dialog_id'] as String?,
      message: json['message'] as String?,
      isYour: json['isYour'] as bool?,
    );

Map<String, dynamic> _$ChatDetailModelToJson(ChatDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversation_id,
      'dialog_id': instance.dialog_id,
      'message': instance.message,
      'createdAt': instance.createdAt,
      'isYour': instance.isYour,
    };
