import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/friend/friend_block_entity.dart';
import 'package:facebook/models/entities/friend/friend_request_entity.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/utils/logger.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook/commons/share_preferences_helper.dart';

part './list_friend_state.dart';

class ListFriendCubit extends Cubit<ListFriendState> {
  FriendRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  ListFriendCubit({this.repository}) : super(ListFriendState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getListFriends(String? userId) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    await getListBlocks();
    List<FriendRequestEntity> listFriends = [];
    try {
      final response = await repository!.getListFriends(token, 0, 20);
      listFriends = response.data!.requestList ?? [];
      for (var i = 0; i < listFriends.length; i++) {
        for (int j = 0; j < state.listBlocks!.length; j++) {
          if (state.listBlocks![j].userId == listFriends[i].userId) {
            listFriends.removeAt(i);
          }
        }
      }
      emit(state.copyWith(
          loadingStatus: LoadStatus.SUCCESS, listFriends: listFriends));
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      logger.e(error);
    }
  }

  Future<void> getListBlocks() async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      final response = await repository!.getListBlock(token, 0, 20);
      emit(state.copyWith(listBlocks: response.data ?? []));
    } catch (error) {
      emit(state.copyWith(listBlocks: []));
      logger.e(error);
    }
  }
}
