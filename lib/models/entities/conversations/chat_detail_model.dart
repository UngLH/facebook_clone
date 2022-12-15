import 'package:json_annotation/json_annotation.dart';

part 'chat_detail_model.g.dart';

@JsonSerializable()
class ChatDetailModel {
  int? id;
  String? conversation_id;
  String? dialog_id;
  String? message;
  String? createdAt;
  bool? isYour;

  ChatDetailModel(
      {this.id,
      this.createdAt,
      this.conversation_id,
      this.dialog_id,
      this.message,
      this.isYour});

  ChatDetailModel copyWith({
    int? id,
    String? conversation_id,
    String? dialog_id,
    String? message,
    String? createdAt,
    bool? isYour,
  }) {
    return ChatDetailModel(
      id: id ?? this.id,
      conversation_id: conversation_id ?? this.conversation_id,
      dialog_id: dialog_id ?? this.dialog_id,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      isYour: isYour ?? this.isYour,
    );
  }

  factory ChatDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ChatDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatDetailModelToJson(this);
}

var chatDetailList = List<String>.filled(10, '')
    .asMap()
    .map((index, str) => MapEntry(
        index,
        ChatDetailModel(
          id: index,
          createdAt: "2019-10-07T13:50:11.633Z",
          dialog_id: "$index",
          conversation_id: "$index",
          message: "message $index",
          isYour: index % 3 == 0 ? true : false,
        )))
    .values
    .toList();
