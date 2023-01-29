// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'friend_entity.g.dart';

@JsonSerializable()
class FriendSuggestEntity {
  @JsonKey(name: "user_id")
  String? userId;
  String? username;
  String? avatar;
  @JsonKey(name: "same_friends")
  String? sameFriend;
  

  FriendSuggestEntity({this.userId, this.username, this.avatar, this.sameFriend});

  FriendSuggestEntity copyWith(
      {String? userId, String? username, String? avatar, String? sameFriend}) {
    return FriendSuggestEntity(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        sameFriend: sameFriend ?? this.sameFriend);
  }

  factory FriendSuggestEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendSuggestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendSuggestEntityToJson(this);
}

@JsonSerializable()
class FriendDataResponse {
  String? total;
  @JsonKey(name: "list_users")
  List<FriendSuggestEntity>? listUsers;
  FriendDataResponse({this.total, this.listUsers});

  FriendDataResponse copyWith({String? total, List<FriendSuggestEntity>? listUsers}) {
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

@JsonSerializable()
class FriendEntity {
  @JsonKey(name: "id")
  String? userId;
  String? username;
  String? avatar;
  @JsonKey(name: "same_friends")
  String? sameFriend;
  String? created;
  FriendEntity({
    this.userId,
    this.username,
    this.avatar,
    this.sameFriend,
    this.created,
  });

  FriendEntity copyWith({
    String? userId,
    String? username,
    String? avatar,
    String? sameFriend,
    String? created,
  }) {
    return FriendEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      sameFriend: sameFriend ?? this.sameFriend,
      created: created ?? this.created,
    );
  }

  factory FriendEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendEntityToJson(this);
}

@JsonSerializable()
class FriendRequestDataResponse {
  @JsonKey(name: "list_user")
  List<FriendEntity>? listUsers;
  String? total;

  FriendRequestDataResponse({
    this.listUsers,
    this.total,
  });

  FriendRequestDataResponse copyWith({
    List<FriendEntity>? listUsers,
    String? total,
  }) {
    return FriendRequestDataResponse(
      listUsers: listUsers ?? this.listUsers,
      total: total ?? this.total,
    );
  }

  factory FriendRequestDataResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestDataResponseToJson(this);

}

@JsonSerializable()
class FriendRequestResponse {
  String? code;
  String? message;
  FriendRequestDataResponse? data;
  FriendRequestResponse({
    this.code,
    this.message,
    this.data,
  });

  FriendRequestResponse copyWith({
    String? code,
    String? message,
    FriendRequestDataResponse? data,
  }) {
    return FriendRequestResponse(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory FriendRequestResponse.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestResponseToJson(this);
}
