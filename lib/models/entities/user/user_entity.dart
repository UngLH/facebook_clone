import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';
@JsonSerializable()
class UserEntity {
  String? username;
  String? password;


  UserEntity({
  this.username,
    this.password,
  });

  UserEntity copyWith({
   String? username,
    String? password,
  }) {
    return UserEntity(
       username: username ?? this.username,
       password: password ?? this.password,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}
