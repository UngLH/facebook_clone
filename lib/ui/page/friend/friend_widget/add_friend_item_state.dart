part of 'add_friend_item_cubit.dart';

class AddFriendItemState extends Equatable {
  String? mode;
  LoadStatus? isAcceptLoading;
  bool? isCancelLoading;

  AddFriendItemState(
      {this.mode,
      this.isAcceptLoading = LoadStatus.SUCCESS,
      this.isCancelLoading});

  AddFriendItemState copyWith(
      {String? mode, LoadStatus? isAcceptLoading, bool? isCancelLoading}) {
    return AddFriendItemState(
        mode: mode ?? this.mode,
        isAcceptLoading: isAcceptLoading ?? this.isAcceptLoading,
        isCancelLoading: isCancelLoading ?? this.isCancelLoading);
  }

  @override
  List<Object?> get props => [mode, isCancelLoading, isAcceptLoading];
}
