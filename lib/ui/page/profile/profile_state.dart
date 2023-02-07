// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_cubit.dart';

class ProfileState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendRequestEntity>? listFriends;
  LoadStatus? loadProfileStatus;
  UserProfileEntity? userProfile;
  ProfileState(
      {this.loadingStatus,
      this.listFriends,
      this.userProfile,
      this.loadProfileStatus});

  @override
  List<Object?> get props =>
      [loadingStatus, listFriends, userProfile, loadProfileStatus];

  ProfileState copyWith({
    LoadStatus? loadingStatus,
    LoadStatus? loadProfileStatus,
    UserProfileEntity? userProfile,
    List<FriendRequestEntity>? listFriends,
  }) {
    return ProfileState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listFriends: listFriends ?? this.listFriends,
        userProfile: userProfile ?? this.userProfile,
        loadProfileStatus: loadProfileStatus ?? this.loadProfileStatus);
  }
}
