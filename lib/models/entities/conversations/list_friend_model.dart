import 'package:facebook/commons/app_images.dart';
import 'package:facebook/models/entities/conversations/story_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'list_friend_model.g.dart';

@JsonSerializable()
class ListFriendModel {
  @JsonKey()
  String? id;
  String? imageAvatarUrl;
  String? name;
  String? shortDescription;
  String? createdAt;
  bool? isActive;
  List<StoryModel>? stories;
  PartnerModel? partner;
  LastMessageModel? lastMessage;

  ListFriendModel(
      {this.id = "",
      this.createdAt = "",
      this.imageAvatarUrl = AppImages.icSignupIntro,
      this.name = "",
      this.shortDescription = "",
      this.isActive = false,
      this.stories = const [],
      this.partner,
      this.lastMessage  
    }) ;

  ListFriendModel copyWith({
    String? id,
    String? imageAvatarUrl,
    String? name,
    String? shortDescription,
    String? createdAt,
    bool? isActive,
    List<StoryModel>? stories,
    PartnerModel? partner,
    LastMessageModel? lastMessage,
  }) {
    return ListFriendModel(
      id: id ?? this.id,
      imageAvatarUrl: imageAvatarUrl ?? this.imageAvatarUrl,
      name: name ?? this.name,
      shortDescription: shortDescription ?? this.shortDescription,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      stories: stories ?? this.stories,
      partner: partner ?? this.partner,
      lastMessage: lastMessage ?? this.lastMessage,
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
            id: "ID",
            createdAt: "2019-10-07T13:50:11.633Z",
            name: "User $index",
            imageAvatarUrl: AppImages.icSignupIntro,
            shortDescription: "AaAaAaAa $index",
            isActive: index % 2 == 0 ? true : false,
            stories: [
              StoryModel(text: "Story $index", imageUrl: null),
              StoryModel(text: null, imageUrl: AppImages.icEmotion),
              StoryModel(text: null, imageUrl: AppImages.testImagePost),
            ],
            partner: PartnerModel(id: "$index", username: "User $index", avatar: AppImages.icFacebookLogo),
            lastMessage: LastMessageModel(message: "message $index", created: "166455335")
      )))
    .values
    .toList();

@JsonSerializable()
class LastMessageModel {
  String? message;
  String? created;
  String? unread;
  LastMessageModel({this.message = "message", this.created = "166839282", this.unread = "1"});

  LastMessageModel copyWith({String? message, String? created, String? unread}) {
    return LastMessageModel(
        message: message ?? this.message, 
        created: created ?? this.created,
        unread: unread ?? this.unread
    );
  }

  factory LastMessageModel.fromJson(Map<String, dynamic> json) =>
      _$LastMessageModelFromJson(json);

  Map<String, dynamic> toJson() => _$LastMessageModelToJson(this);
}

@JsonSerializable()
class PartnerModel {
  String? id;
  String? username;
  String? avatar;
  PartnerModel({this.id = "", this.username = "User", this.avatar = AppImages.icRoundFacebookLogo});

  PartnerModel copyWith({String? id, String? username, String? avatar}) {
    return PartnerModel(
        id: id ?? this.id, 
        username: username ?? this.username, 
        avatar: avatar ?? this.avatar, 
    );
  }

  factory PartnerModel.fromJson(Map<String, dynamic> json) =>
      _$PartnerModelFromJson(json);

  Map<String, dynamic> toJson() => _$PartnerModelToJson(this);
}

@JsonSerializable()
class ListConversationResponse {
  String? code;
  String? message;
  List<ListFriendModel>? data;
  int? numNewMessage;
  ListConversationResponse({
    this.code = "",
    this.message = "",
    this.data = const [],
    this.numNewMessage = 0,
  });

  ListConversationResponse copyWith({
    String? code = "",
    String? message = "",
    List<ListFriendModel>? data =  const [],
  }) {
    return ListConversationResponse(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory ListConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ListConversationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListConversationResponseToJson(this);
}