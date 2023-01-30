import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/friend/friend_block_entity.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/entities/friend/friend_request_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'home_friends_state.dart';

class HomeFriendsCubit extends Cubit<HomeFriendsState> {
  FriendRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  HomeFriendsCubit({this.repository}) : super(HomeFriendsState());

  @override
  Future<void> close() {
    return super.close();
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

  Future<void> getListFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      final response = await repository!.getListFriends(token, 0, 20);
      emit(state.copyWith(listFriends: response.data!.requestList ?? []));
    } catch (error) {
      emit(state.copyWith(listFriends: []));
      logger.e(error);
    }
  }

  Future<void> getListSuggestFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    await getListBlocks();
    await getListFriends();
    List<FriendSuggestEntity> suggestFriends = [];
    try {
      final response = await repository?.getSuggestFriends(token, 0, 20);
      suggestFriends = response!.data!.listUsers ?? [];
      for (int i = 0; i < suggestFriends.length; i++) {
        for (int j = 0; j < state.listFriends!.length; j++) {
          if (state.listFriends![j].userId == suggestFriends[i].userId) {
            suggestFriends.removeAt(i);
            print("user $i: ${suggestFriends[i].userId}");
          }
        }
      }
      for (int i = 0; i < suggestFriends.length; i++) {
        for (int j = 0; j < state.listBlocks!.length; j++) {
          if (state.listBlocks![j].userId == suggestFriends[i].userId) {
            suggestFriends.removeAt(i);
          }
        }
      }
      emit(state.copyWith(
          loadingStatus: LoadStatus.SUCCESS,
          listSuggestFriends: suggestFriends));
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state.copyWith(loadingStatus: LoadStatus.EMPTY));
        } else {
          emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
        }
      }
    }
  }

  Future<void> getListRequestFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository?.getRequestFriends(token, 0, 20);
      if (response != null) {
        emit(state.copyWith(
            loadingStatus: LoadStatus.SUCCESS,
            loadingRequestFriend: LoadStatus.SUCCESS,
            listRequestFriends: response.data!.requestList));
      }
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state.copyWith(
              loadingRequestFriend: LoadStatus.EMPTY, listRequestFriends: []));
        } else {
          emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
        }
      }
    }
  }
}
