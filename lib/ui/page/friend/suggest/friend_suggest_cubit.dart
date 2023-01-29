import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import 'package:facebook/commons/share_preferences_helper.dart';

part 'friend_suggest_state.dart';

class FriendSuggestCubit extends Cubit<FriendSuggestState> {
  FriendRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  FriendSuggestCubit({this.repository}) : super(FriendSuggestState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getListSuggestFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository?.getSuggestFriends(token, 0, 20);
      if (response != null) {
        emit(state.copyWith(
            loadingStatus: LoadStatus.SUCCESS,
            listSuggestFriends: response.data!.listUsers));
      }
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

  Future<void> getMoreSuggestFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    int index = state.listSuggestFriends!.length;
    try {
      final response = await repository?.getSuggestFriends(token, index, index + 20);
      if (response != null) {
      List<FriendSuggestEntity>? listUsers = state.listSuggestFriends;
      if(response.data!.listUsers!.isEmpty){
        print("hello");
        return ;
      }
      listUsers?.addAll(response.data!.listUsers!);
      print("Chieudai" + listUsers!.length.toString());
      emit(state.copyWith(
            listSuggestFriends: listUsers));
      }
    } catch (error) {
      logger.e(error);
    }
  }
}