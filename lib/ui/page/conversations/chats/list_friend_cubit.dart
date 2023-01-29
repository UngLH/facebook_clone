import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/subjects.dart';

part 'list_friend_state.dart';

class ListFriendCubit extends Cubit<ListFriendState> {
  AuthRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  ListFriendCubit({
    this.repository,
  }) : super(ListFriendState(friendList: const []));

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getListConversation() async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      loadingController.sink.add(LoadStatus.LOADING);
      final result =
          await repository?.getListConversation(token!, 0, 10);
      if (result!.data!.isNotEmpty) {
        print(ListFriendModel().toJson());
        emit(state.copyWith(
          friendList: result.data
        ));
      }
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
      if (error is DioError) {
        print("error");
      }
    }
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
    print(1);
    return (
      state.friendList?.where((element) {
        if (element.name != null) {
          if (element.name!.contains(state.searchValue!)) {
            return true;
          }
          return false;
        }
        return true;
      }).toList()
    );
  }
}
