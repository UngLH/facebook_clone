part of 'home_friends_cubit.dart';

class HomeFriendsState extends Equatable {
  LoadStatus? loadingStatus;
  LoadStatus? loadingRequestFriend;
  LoadStatus? loadingFriendStatus;
  LoadStatus? loadingBlockStatus;
  List<FriendSuggestEntity>? listSuggestFriends;
  List<FriendRequestEntity>? listRequestFriends;
  List<FriendRequestEntity>? listFriends;
  List<FriendBlockEntity>? listBlocks;

  HomeFriendsState(
      {this.loadingStatus = LoadStatus.LOADING,
      this.loadingRequestFriend = LoadStatus.LOADING,
      this.loadingFriendStatus,
      this.loadingBlockStatus,
      this.listSuggestFriends,
      this.listRequestFriends,
      this.listBlocks,
      this.listFriends});

  HomeFriendsState copyWith(
      {LoadStatus? loadingStatus,
      LoadStatus? loadingFriendStatus,
      LoadStatus? loadingBlockStatus,
      List<FriendSuggestEntity>? listSuggestFriends,
      LoadStatus? loadingRequestFriend,
      List<FriendRequestEntity>? listRequestFriends,
      List<FriendRequestEntity>? listFriends,
      List<FriendBlockEntity>? listBlocks}) {
    return HomeFriendsState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        loadingBlockStatus: loadingBlockStatus ?? this.loadingBlockStatus,
        loadingFriendStatus: loadingFriendStatus ?? this.loadingFriendStatus,
        loadingRequestFriend: loadingRequestFriend ?? this.loadingRequestFriend,
        listSuggestFriends: listSuggestFriends ?? this.listSuggestFriends,
        listRequestFriends: listRequestFriends ?? this.listRequestFriends,
        listBlocks: listBlocks ?? this.listBlocks,
        listFriends: listFriends ?? this.listFriends);
  }

  @override
  List<Object?> get props => [
        loadingStatus,
        loadingBlockStatus,
        loadingFriendStatus,
        listSuggestFriends,
        listRequestFriends,
        loadingRequestFriend,
        listFriends,
        listBlocks
      ];
}
