import 'package:json_annotation/json_annotation.dart';
part 'friend_request_entity.g.dart';

@JsonSerializable()
class FriendRequestEntity {
  @JsonKey(name: "id")
  String? userId;
  String? username;
  String? avatar;
  @JsonKey(name: "same_friends")
  String? sameFriend;
  String? created;

  FriendRequestEntity(
      {this.userId, this.username, this.avatar, this.sameFriend, this.created});

  FriendRequestEntity copyWith(
      {String? userId,
      String? username,
      String? avatar,
      String? sameFriend,
      String? created}) {
    return FriendRequestEntity(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        sameFriend: sameFriend ?? this.sameFriend,
        created: created ?? this.created);
  }

  factory FriendRequestEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendRequestEntityToJson(this);
}

@JsonSerializable()
class RequestData {
  @JsonKey(name: "request")
  List<FriendRequestEntity>? requestList;
  String? total;
  RequestData({this.requestList, this.total});

  RequestData copyWith(
      {List<FriendRequestEntity>? requestList, String? total}) {
    return RequestData(
        requestList: requestList ?? this.requestList,
        total: total ?? this.total);
  }

  factory RequestData.fromJson(Map<String, dynamic> json) =>
      _$RequestDataFromJson(json);

  Map<String, dynamic> toJson() => _$RequestDataToJson(this);
}

@JsonSerializable()
class RequestFriendResponse {
  String? code;
  String? message;
  RequestData? data;

  RequestFriendResponse({this.code, this.message, this.data});

  RequestFriendResponse copyWith(
      {String? code, String? message, RequestData? data}) {
    return RequestFriendResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory RequestFriendResponse.fromJson(Map<String, dynamic> json) =>
      _$RequestFriendResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RequestFriendResponseToJson(this);
}
