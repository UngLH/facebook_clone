import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_friend_item_state.dart';

class AddFriendItemCubit extends Cubit<AddFriendItemState> {
  FriendRepository? repository;
  AddFriendItemCubit({this.repository}) : super(AddFriendItemState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> setRequestFriend(String? userId) async {
    emit(state.copyWith(isAcceptLoading: LoadStatus.LOADING));
    String? token = await SharedPreferencesHelper.getToken();
    try {
      emit(state.copyWith(isAcceptLoading: LoadStatus.SUCCESS));
      await repository?.setRequestFriend(token, userId);
    } catch (error) {
      emit(state.copyWith(isAcceptLoading: LoadStatus.SUCCESS));
      logger.e(error);
    }
  }

  Future<void> setAcceptFriend(String? userId, String? isAccept) async {
    emit(state.copyWith(isAcceptLoading: LoadStatus.LOADING));
    String? token = await SharedPreferencesHelper.getToken();
    try {
      emit(state.copyWith(isAcceptLoading: LoadStatus.SUCCESS));
      await repository?.setAcceptFriend(token, userId, isAccept);
    } catch (error) {
      emit(state.copyWith(isAcceptLoading: LoadStatus.SUCCESS));
      logger.e(error);
    }
  }
}
