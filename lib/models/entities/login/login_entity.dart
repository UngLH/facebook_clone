import 'package:json_annotation/json_annotation.dart';

part 'login_entity.g.dart';

@JsonSerializable()
class LoginEntity {
  String? id;
  String? username;
  String? token;
  String? avatar;
  String? active;

  LoginEntity({this.id, this.username, this.token, this.avatar, this.active});

  LoginEntity copyWith({
    String? id,
    String? username,
    String? token,
    String? avatar,
    String? active,
  }) {
    return LoginEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        token: token ?? this.token,
        avatar: avatar ?? this.avatar,
        active: active ?? this.active);
  }

  factory LoginEntity.fromJson(Map<String, dynamic> json) =>
      _$LoginEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LoginEntityToJson(this);
}
