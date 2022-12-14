import 'package:json_annotation/json_annotation.dart';

part 'account_user.g.dart';

@JsonSerializable()
class AccountUser {
  String? avatarImg;
  String? name;

  AccountUser({this.avatarImg, this.name});

  AccountUser copyWith({
    String? avatarImg,
    String? name,
  }) {
    return AccountUser(
      avatarImg: avatarImg ?? this.avatarImg,
      name: name ?? this.name,
    );
  }

  factory AccountUser.fromJson(Map<String, dynamic> json) =>
      _$AccountUserFromJson(json);

  Map<String, dynamic> toJson() => _$AccountUserToJson(this);
}

var yourAccount = AccountUser(
  avatarImg: "",
  name: "",
);
