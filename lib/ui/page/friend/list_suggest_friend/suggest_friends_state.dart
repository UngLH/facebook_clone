part of 'suggest_friends_cubit.dart';

class SuggestFriendsState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendEntity>? listSuggestFriends;

  List<FriendRequestEntity>? listRequestFriends;

  SuggestFriendsState(
      {this.loadingStatus = LoadStatus.LOADING, this.listSuggestFriends, this.listRequestFriends});

  SuggestFriendsState copyWith(
      {LoadStatus? loadingStatus, List<FriendEntity>? listSuggestFriends, List<FriendRequestEntity>? listRequestFriends}) {
    return SuggestFriendsState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listSuggestFriends: listSuggestFriends ?? this.listSuggestFriends,
        listRequestFriends: listRequestFriends ?? this.listRequestFriends);
  }

  @override
  List<Object?> get props => [loadingStatus, listSuggestFriends, listRequestFriends];
}
