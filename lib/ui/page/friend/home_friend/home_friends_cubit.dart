import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
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

  Future<void> getListRequestFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository?.getRequestFriends(token, 0, 20);
      if (response != null) {
        emit(state.copyWith(
            loadingStatus: LoadStatus.SUCCESS,
            listRequestFriends: response.data!.listUsers));
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
}
