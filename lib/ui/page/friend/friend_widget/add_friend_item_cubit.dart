part of 'add_friend_item_state.dart';

class AddFriendItemCubit extends Cubit<AddFriendItemState> {
  AddFriendItemCubit(AddFriendItemState initialState) : super(initialState);
  
  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> accept() async {
    emit(state.copyWith(mode: "accept"));
  }

  Future<void> reject() async {
    emit(state.copyWith(mode: "reject"));
  }

  Future<void> addFriend() async {
    emit(state.copyWith(mode: "add_friend"));
  }

  Future<void> remove() async {
    emit(state.copyWith(mode: "remove"));
  }
}