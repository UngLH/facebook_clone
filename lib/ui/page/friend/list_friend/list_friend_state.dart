// ignore_for_file: public_member_api_docs, sort_constructors_first

part of './list_friend_cubit.dart';

class ListFriendState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendRequestEntity>? listFriends;
  ListFriendState({
    this.loadingStatus,
    this.listFriends,
  });

  @override
  List<Object?> get props => [loadingStatus, listFriends];

  ListFriendState copyWith({
    LoadStatus? loadingStatus,
    List<FriendRequestEntity>? listFriends,
  }) {
    return ListFriendState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listFriends: listFriends ?? this.listFriends,
    );
  }
}
