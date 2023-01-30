import 'package:json_annotation/json_annotation.dart';
part 'friend_block_entity.g.dart';

@JsonSerializable()
class FriendBlockEntity {
  @JsonKey(name: "id")
  String? userId;
  String? username;
  String? avatar;

  FriendBlockEntity({this.userId, this.username, this.avatar});

  FriendBlockEntity copyWith(
      {String? userId, String? username, String? avatar}) {
    return FriendBlockEntity(
        userId: userId ?? this.userId,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar);
  }

  factory FriendBlockEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendBlockEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendBlockEntityToJson(this);
}

@JsonSerializable()
class ListBlockResponse {
  String? code;
  String? message;
  List<FriendBlockEntity>? data;

  ListBlockResponse({this.code, this.message, this.data});

  ListBlockResponse copyWith(
      {String? code, String? message, List<FriendBlockEntity>? data}) {
    return ListBlockResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory ListBlockResponse.fromJson(Map<String, dynamic> json) =>
      _$ListBlockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ListBlockResponseToJson(this);
}
