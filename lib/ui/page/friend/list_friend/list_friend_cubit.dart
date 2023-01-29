import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/ui/page/conversations/chats/list_friend_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/utils/logger.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
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
    // String? token = await SharedPreferencesHelper.getToken();
    // emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    // try {
    //   final response = await repository?.getUserFriends(token,userId, 0, 20);
    //   if (response != null) {
    //     emit(state.copyWith(
    //         loadingStatus: LoadStatus.SUCCESS,
    //         listFriends: response.data!.listUsers));
    //   }
    // } catch (error) {
    //   logger.e(error);
    //   if (error is DioError) {
    //     if (error.response!.data["message"] == "No data or end of list data") {
    //       emit(state.copyWith(loadingStatus: LoadStatus.EMPTY));
    //     } else {
    //       emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
    //     }
    //   }
    // }
    emit(state.copyWith(listFriends: friendList));
  }

  List<FriendEntity> friendList = [
    FriendEntity(username: "test", sameFriend: "1", created: "15616515"),
    FriendEntity(username: "test Le Nguyen", sameFriend: "2", created: "15616515"),
    FriendEntity(username: "test Le Nguyen", sameFriend: "3", created: "15616515"),
    FriendEntity(username: "test Hello ", sameFriend: "4", created: "15616515"),
    FriendEntity(username: "test ac", sameFriend: "5", created: "15616515"),
  ];

  Future<void> sortDecrement() async {
    List<FriendEntity>? listUser = state.listFriends;
    listUser!.sort(((a, b) {
      int createdA = int.parse(a.created!);
      int createdB = int.parse(b.created!);
      return createdA.compareTo(createdB);
    }));
    emit(state.copyWith(listFriends: listUser));
  }

  Future<void> sortIncrement() async {
    List<FriendEntity>? listUser = state.listFriends;
    listUser!.sort(((a, b) {
      int createdA = int.parse(a.created!);
      int createdB = int.parse(b.created!);
      return createdB.compareTo(createdA); 
    }));
    emit(state.copyWith(listFriends: listUser));
  }

  Future<void> getMoreListFriends(String? userId) async {
    String? token = await SharedPreferencesHelper.getToken();
    int index = state.listFriends!.length;
    try {
      final response = await repository?.getUserFriends(token,userId, index, index + 20);
      if (response != null) {
      List<FriendEntity>? listUsers = state.listFriends;
      if(response.data!.listUsers!.isEmpty){
        return ;
      }
      listUsers?.insertAll(0, response.data!.listUsers!);
        emit(state.copyWith(
            listFriends: listUsers));
      }
    } catch (error) {
      logger.e(error);
    }
  }

}