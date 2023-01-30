import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/friend/friend_request_entity.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/utils/logger.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook/commons/share_preferences_helper.dart';

part './friend_request_state.dart';

class FriendRequestCubit extends Cubit<FriendRequestState> {
  FriendRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  FriendRequestCubit({this.repository}) : super(FriendRequestState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getListRequestFriends() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository?.getRequestFriends(token, 0, 1000);
      if (response != null) {
        emit(state.copyWith(
            loadingStatus: LoadStatus.SUCCESS,
            listRequestFriends: response.data!.requestList));
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

  Future<void> sortDecrement() async {
    List<FriendRequestEntity>? listUser = state.listRequestFriends;
    listUser!.sort(((a, b) {
      int createdA = int.parse(a.created!);
      int createdB = int.parse(b.created!);
      return createdA.compareTo(createdB);
    }));
    emit(state.copyWith(listRequestFriends: listUser));
  }

  Future<void> sortIncrement() async {
    List<FriendRequestEntity>? listUser = state.listRequestFriends;
    listUser!.sort(((a, b) {
      int createdA = int.parse(a.created!);
      int createdB = int.parse(b.created!);
      return createdB.compareTo(createdA);
    }));
    emit(state.copyWith(listRequestFriends: listUser));
  }
}
