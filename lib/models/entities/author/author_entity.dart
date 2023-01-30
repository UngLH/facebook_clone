import 'package:json_annotation/json_annotation.dart';

part 'author_entity.g.dart';

@JsonSerializable()
class AuthorEntity {
  String? id;
  String? username;
  String? avatar;

  AuthorEntity({this.id, this.username, this.avatar});

  AuthorEntity copyWith({
    String? id,
    String? username,
    String? avatar,
  }) {
    return AuthorEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar);
  }

  factory AuthorEntity.fromJson(Map<String, dynamic> json) =>
      _$AuthorEntityFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorEntityToJson(this);
}
