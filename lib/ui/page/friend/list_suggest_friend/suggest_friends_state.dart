part of 'suggest_friends_cubit.dart';

class SuggestFriendsState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendEntity>? listSuggestFriends;

  SuggestFriendsState(
      {this.loadingStatus = LoadStatus.LOADING, this.listSuggestFriends});

  SuggestFriendsState copyWith(
      {LoadStatus? loadingStatus, List<FriendEntity>? listSuggestFriends}) {
    return SuggestFriendsState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listSuggestFriends: listSuggestFriends ?? this.listSuggestFriends);
  }

  @override
  List<Object?> get props => [loadingStatus, listSuggestFriends];
}
