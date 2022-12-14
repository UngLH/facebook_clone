part of 'list_friend_cubit.dart';

class ListFriendState extends Equatable {
  LoadingStatus? loadingStatus;
  String? searchValue;
  List<ListFriendModel>? friendList;

  ListFriendState({
    this.loadingStatus,
    this.searchValue = "",
    this.friendList,
  });

  ListFriendState copyWith({
    LoadingStatus? loadingStatus,
    String? searchValue,
    List<ListFriendModel>? friendList,
  }) {
    return ListFriendState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      searchValue: searchValue ?? this.searchValue,
      friendList: friendList ?? this.friendList,
    );
  }

  @override
  List<Object?> get props => [loadingStatus, searchValue, friendList];
}
