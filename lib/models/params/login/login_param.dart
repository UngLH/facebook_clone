import 'package:json_annotation/json_annotation.dart';

part 'login_param.g.dart';

@JsonSerializable()
class LoginParam {
  String? phoneNumber;
  String? password;

  LoginParam({this.phoneNumber, this.password});

  LoginParam copyWith({String? phoneNumber, String? password}) {
    return LoginParam(
     phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  factory LoginParam.fromJson(Map<String, dynamic> json) =>
      _$LoginParamFromJson(json);

  Map<String, dynamic> toJson() => _$LoginParamToJson(this);
}
