import 'package:json_annotation/json_annotation.dart';

part 'story_model.g.dart';

@JsonSerializable()
class StoryModel {
  @JsonKey(name: "_id")
  String? id;
  String? text;
  String? imageUrl;

  StoryModel({
    this.id,
    this.text,
    this.imageUrl,
  });

  StoryModel copyWith({String? id, String? text, String? imageUrl}) {
    return StoryModel(
        id: id ?? this.id,
        text: text ?? this.text,
        imageUrl: imageUrl ?? this.imageUrl);
  }

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$StoryModelToJson(this);
}
