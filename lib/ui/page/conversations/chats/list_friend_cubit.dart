import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';

part 'list_friend_state.dart';

class ListFriendCubit extends Cubit<ListFriendState> {
  AuthRepository? authRepository;

  ListFriendCubit({
    this.authRepository,
  }) : super(ListFriendState(friendList: friendList));

  @override
  Future<void> close() {
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(searchValue: ""));
  }

  void searchValueChange(String? searchValue) {
    // ignore: avoid_print
    emit(state.copyWith(
      searchValue: searchValue,
    ));
  }

  List<ListFriendModel>? searchConversations() {
    return (
      state.friendList?.where((element) {
        if (element.name!.contains(state.searchValue!)) {
          return true;
        }
        return false;
      }).toList()
    );
  }
}
