import 'package:facebook/commons/app_images.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_friend_model.g.dart';

class StoryModel {
  String? text;
  String? imageUrl;
  
  StoryModel({
    this.text,
    this.imageUrl,
  });
}

@JsonSerializable()
class ListFriendModel {
  int? id;
  String? imageAvatarUrl;
  String? name;
  String? shortDescription;
  String? createdAt;
  bool? isActive;
  List<StoryModel>? stories;

  ListFriendModel(
      {this.id,
      this.createdAt,
      this.imageAvatarUrl,
      this.name,
      this.shortDescription,
      this.isActive,
      this.stories});

  ListFriendModel copyWith({
    int? id,
    String? imageAvatarUrl,
    String? name,
    String? shortDescription,
    String? createdAt,
    bool? isActive,
    List<StoryModel>? stories,
  }) {
    return ListFriendModel(
      id: id ?? this.id,
      imageAvatarUrl: imageAvatarUrl ?? this.imageAvatarUrl,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      stories: stories ?? this.stories,
    );
  }

  factory ListFriendModel.fromJson(Map<String, dynamic> json) =>
      _$ListFriendModelFromJson(json);

  Map<String, dynamic> toJson() => _$ListFriendModelToJson(this);
}

var friendList = List<String>.filled(20, '')
    .asMap()
    .map((index, str) => MapEntry(
        index,
        ListFriendModel(
          id: index,
          createdAt: "2019-10-07T13:50:11.633Z",
          name: "User $index",
          imageAvatarUrl: AppImages.icSignupIntro,
          shortDescription: "AaAaAaAa $index",
          isActive: index % 2 == 0 ? true : false,
          stories: [
            StoryModel(text: "Story $index", imageUrl: null),
            StoryModel(text: null, imageUrl: AppImages.icEmotion),
            StoryModel(text: null, imageUrl: AppImages.testImagePost),
          ]
        )))
    .values
    .toList();
