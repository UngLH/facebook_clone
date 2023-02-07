// ignore_for_file: public_member_api_docs, sort_constructors_first

part of './list_friend_cubit.dart';

class ListFriendState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendRequestEntity>? listFriends;
  List<FriendBlockEntity>? listBlocks;
  ListFriendState({this.loadingStatus, this.listFriends, this.listBlocks});

  @override
  List<Object?> get props => [loadingStatus, listFriends, listBlocks];

  ListFriendState copyWith(
      {LoadStatus? loadingStatus,
      List<FriendRequestEntity>? listFriends,
      List<FriendBlockEntity>? listBlocks}) {
    return ListFriendState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listFriends: listFriends ?? this.listFriends,
        listBlocks: listBlocks ?? this.listBlocks);
  }
}
