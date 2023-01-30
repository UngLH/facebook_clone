part of './friend_request_state.dart';

class FriendRequestCardCubit extends Cubit<FriendRequestCardState> {
  FriendRequestCardCubit(FriendRequestCardState initialState) : super(initialState);

  @override
  Future<void> close() {
    return super.close();
  }
  
  Future<void> accept() async {
    emit(state.copyWith(code: "accept"));
  }

  Future<void> reject() async {
    emit(state.copyWith(code: "reject"));
  }
}
class FriendRequestCubit extends Cubit<FriendRequestState> {
  FriendRequestCubit() : super(FriendRequestState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> sortIncrement() async {
    state.friendEntities?.sort((a, b) {
      return a.created!.compareTo(b.created!);
    });
    emit(state);
  }

  Future<void> sortDecrement() async {
    state.friendEntities?.sort((a, b) {
      return b.created!.compareTo(a.created!);
    });
    emit(state);
  }

  Future<void> getListRequest() async {
    List<FriendEntity> friendEntityList = friends;
    emit(state.copyWith(friendEntities: friendEntityList));
  }
}

