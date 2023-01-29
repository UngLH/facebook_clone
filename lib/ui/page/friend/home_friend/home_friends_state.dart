part of 'home_friends_cubit.dart';

class HomeFriendsState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendSuggestEntity>? listSuggestFriends;

  List<FriendEntity>? listRequestFriends;

  HomeFriendsState(
      {this.loadingStatus = LoadStatus.LOADING, this.listSuggestFriends, this.listRequestFriends});

  HomeFriendsState copyWith(
      {LoadStatus? loadingStatus, List<FriendSuggestEntity>? listSuggestFriends, List<FriendEntity>? listRequestFriends}) {
    return HomeFriendsState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listSuggestFriends: listSuggestFriends ?? this.listSuggestFriends,
        listRequestFriends: listRequestFriends ?? this.listRequestFriends);
  }

  @override
  List<Object?> get props => [loadingStatus, listSuggestFriends, listRequestFriends];
}
