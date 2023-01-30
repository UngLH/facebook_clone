// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class FriendEntity {
  String? id;
  String? name;
  @JsonKey(name: "avatar")
  String? avatarUrl;
  @JsonKey(name: "same_friends")
  int? sameFriends;
  String? created;

  FriendEntity({
    this.id,
    this.name,
    this.avatarUrl,
    this.sameFriends,
    this.created
  });

  FriendEntity copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    int? sameFriends,
    String? created
  }){
    return FriendEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      sameFriends: sameFriends ?? this.sameFriends,
      created: created ?? this.created
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatarUrl': avatarUrl,
      'sameFriends': sameFriends,
      'created': created,
    };
  }

  factory FriendEntity.fromMap(Map<String, dynamic> map) {
    return FriendEntity(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      avatarUrl: map['avatarUrl'] != null ? map['avatarUrl'] as String : null,
      sameFriends: map['sameFriends'] != null ? map['sameFriends'] as int : null,
      created: map['created'] != null ? map['created'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory FriendEntity.fromJson(String source) => FriendEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}

List<FriendEntity> friends = [
  FriendEntity(name: "Tran Cong Hoang", sameFriends: 3, created: "1 tuan truoc"),
  FriendEntity(name: "Le Truong Nguyen", sameFriends: 2, created: "2 tuan truoc"),
  FriendEntity(name: "Nong Manh Thang", sameFriends: 3, created: "3 tuan truoc"),
  FriendEntity(name: "Tran Quoc Dat", sameFriends: 3, created: "4 tuan truoc"),
  FriendEntity(name: "simurator", sameFriends: 3, created: "5 tuan truoc"),
  FriendEntity(name: "Nguyễn Văn Long", sameFriends: 3, created: "7 tuan truoc"),
  FriendEntity(name: "Nguyễn Hùng Sơn", sameFriends: 3, created: "9 tuan truoc"),
  FriendEntity(name: "Trần Bá Trinh", sameFriends: 3, created: "12 tuan truoc"),
  FriendEntity(name: "Lê Trọng Khánh", sameFriends: 3, created: "15 tuan truoc"),
  FriendEntity(name: "Thân Minh Nam", sameFriends: 3, created: "17 tuan truoc"),
  FriendEntity(name: "Lê Bá Long", sameFriends: 3, created: "25 tuan truoc"),
  FriendEntity(name: "Đỗ Đại học", sameFriends: 3, created: "14 tuan truoc"),
];