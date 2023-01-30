// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/ui/page/friend/model/friend_entity.dart';

part './friend_request_cubit.dart';

class FriendRequestCardState extends Equatable {
  String? code;
  String? name;
  String? avatarUrl;
  String? created;
  int? sameFriends;
  FriendRequestCardState({
    this.code,
    this.name,
    this.avatarUrl,
    this.created,
    this.sameFriends,
  });
  

  FriendRequestCardState copyWith({
    String? code,
    String? name,
    String? avatarUrl,
    String? created,
    int? sameFriends,
  }) {
    return FriendRequestCardState(
      code: code ?? this.code,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      created: created ?? this.created,
      sameFriends: sameFriends ?? this.sameFriends,
    );
  }
  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      code,
      name,
      avatarUrl,
      created,
      sameFriends,
    ];
  }
}

class FriendRequestState extends Equatable {
  List<FriendEntity>? friendEntities;
  
  FriendRequestState({
    this.friendEntities,
  });
  
  @override
  List<Object?> get props => [friendEntities];


  FriendRequestState copyWith({
    List<FriendEntity>? friendEntities,
  }) {
    return FriendRequestState(
      friendEntities: friendEntities ?? this.friendEntities,
    );
  }

}
