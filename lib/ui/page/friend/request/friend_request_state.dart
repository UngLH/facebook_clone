// ignore_for_file: public_member_api_docs, sort_constructors_first

part of './friend_request_cubit.dart';

class FriendRequestState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendEntity>? listRequestFriends;
  FriendRequestState({
    this.loadingStatus,
    this.listRequestFriends,
  });
  
  @override
  List<Object?> get props => [loadingStatus, listRequestFriends];


  FriendRequestState copyWith({
    LoadStatus? loadingStatus,
    List<FriendEntity>? listRequestFriends,
  }) {
    return FriendRequestState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      listRequestFriends: listRequestFriends ?? this.listRequestFriends,
    );
  }

}
