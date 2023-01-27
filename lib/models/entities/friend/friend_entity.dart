import 'package:json_annotation/json_annotation.dart';

part 'friend_entity.g.dart';

@JsonSerializable()
class FriendEntity {
  @JsonKey(name: "user_id")
  String? userId;
  String? username;
  String? avatar;
  @JsonKey(name: "same_friend")
  String? sameFriend;

  FriendEntity({this.userId, this.username, this.avatar, this.sameFriend});

  FriendEntity copyWith(
      {String? userId, String? username, String? avatar, String? sameFriend}) {
    return FriendEntity(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        sameFriend: sameFriend ?? this.sameFriend);
  }

  factory FriendEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendEntityToJson(this);
}

@JsonSerializable()
class FriendDataResponse {
  String? total;
  @JsonKey(name: "list_users")
  List<FriendEntity>? listUsers;
  FriendDataResponse({this.total, this.listUsers});

  FriendDataResponse copyWith({String? total, List<FriendEntity>? listUsers}) {
    return FriendDataResponse(
        total: total ?? this.total, listUsers: listUsers ?? this.listUsers);
  }

  factory FriendDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendDataResponseToJson(this);
}

@JsonSerializable()
class FriendSuggestResponse {
  String? code;
  String? message;
  FriendDataResponse? data;

  FriendSuggestResponse({this.code, this.message, this.data});

  FriendSuggestResponse copyWith(
      {String? code, String? message, FriendDataResponse? data}) {
    return FriendSuggestResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory FriendSuggestResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendSuggestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendSuggestResponseToJson(this);
}
