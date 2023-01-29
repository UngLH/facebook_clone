part of './friend_suggest_cubit.dart';


class FriendSuggestState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendSuggestEntity>? listSuggestFriends;
  FriendSuggestState({
    this.loadingStatus,
    this.listSuggestFriends,
  });
  
  @override
  List<Object?> get props => [loadingStatus, listSuggestFriends];


  FriendSuggestState copyWith({
    LoadStatus? loadingStatus,
    List<FriendSuggestEntity>? listSuggestFriends,
  }) {
    return FriendSuggestState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listSuggestFriends: listSuggestFriends ?? this.listSuggestFriends,
    );
  }

}
