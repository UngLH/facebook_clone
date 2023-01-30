import 'package:json_annotation/json_annotation.dart';

part 'user_profile_entity.g.dart';

@JsonSerializable()
class UserProfileEntity {
  String? id;
  String? username;
  String? created;
  String? description;
  String? avatar;
  @JsonKey(name: "cover_image")
  String? coverImage;
  String? listing;
  String? link;
  String? address;
  String? city;
  String? country;
  @JsonKey(name: "is_friend")
  String? isFriend;
  String? online;
  UserProfileEntity(
      {this.id,
      this.username,
      this.created,
      this.description,
      this.avatar,
      this.address,
      this.coverImage,
      this.link,
      this.country,
      this.city,
      this.listing,
      this.isFriend,
      this.online});

  UserProfileEntity copyWith(
      {String? id,
      String? username,
      String? created,
      String? description,
      String? avatar,
      String? coverImage,
      String? listing,
      String? link,
      String? address,
      String? city,
      String? country,
      String? isFriend,
      String? online}) {
    return UserProfileEntity(
        id: id ?? this.id,
        username: username ?? this.username,
        created: created ?? this.created,
        description: description ?? this.description,
        avatar: avatar ?? this.avatar,
        coverImage: coverImage ?? this.coverImage,
        listing: listing ?? this.listing,
        link: link ?? this.link,
        address: address ?? this.address,
        city: city ?? this.city,
        country: country ?? this.country,
        isFriend: isFriend ?? this.isFriend,
        online: online ?? this.online);
  }

  factory UserProfileEntity.fromJson(Map<String, dynamic> json) =>
      _$UserProfileEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileEntityToJson(this);
}

@JsonSerializable()
class ProfileResponse {
  String? code;
  String? message;
  UserProfileEntity? data;

  ProfileResponse({this.message, this.code, this.data});

  ProfileResponse copyWith(
      {String? code, String? message, UserProfileEntity? data}) {
    return ProfileResponse(
        code: code ?? this.code,
        message: message ?? this.message,
        data: data ?? this.data);
  }

  factory ProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$ProfileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileResponseToJson(this);
}
