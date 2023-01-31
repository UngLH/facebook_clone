import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/app_images.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/models/entities/conversations/story_model.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
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
  }) : super(ListFriendState(friendList: friendList));

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
        var res = result.data!.map((e) {
          e.stories = [
            StoryModel(text: e.partner!.username, imageUrl: null),
            StoryModel(text: null, imageUrl: AppImages.icEmotion),
            StoryModel(text: null, imageUrl: AppImages.testImagePost),
          ];
          return e;
        }).toList();
        List<FriendSuggestEntity> suggestFriends = [];
        final response = await repository?.getSuggestFriends(token, 0, 20);
        suggestFriends = response!.data!.listUsers ?? [];
        var newData = suggestFriends.asMap()
          .map((index, data) => MapEntry(
              index,
              ListFriendModel(
                  id: data.userId,
                  createdAt: "2019-10-07T13:50:11.633Z",
                  name: data.username,
                  imageAvatarUrl: data.avatar ?? AppImages.icSignupIntro,
                  shortDescription: "message $index",
                  isActive: index % 2 == 0 ? true : false,
                  stories: [
                    StoryModel(text: "Story $index", imageUrl: null),
                    StoryModel(text: null, imageUrl: AppImages.icEmotion),
                    StoryModel(text: null, imageUrl: AppImages.testImagePost),
                  ],
                  partner: PartnerModel(id: data.userId, username: data.username, avatar: data.avatar ?? AppImages.icSignupIntro),
                  lastMessage: LastMessageModel(message: "message $index", created: "166283928")
            )))
          .values
          .toList()
          .where((element) {
            for (var i = 0; i < result.data!.length; i++) {
              if (result.data![i].partner!.id == element.partner!.id) {
                return false;
              }
            }
            return true;
          }).toList();
        emit(state.copyWith(
          friendList: [...{...[...res, ...newData, ...friendList]}]
        ));
      }
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
      if (error is DioError) {
        print("error");
      }
      await getSuggestConversations();
    }
  }

  Future<void> getSuggestConversations() async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      loadingController.sink.add(LoadStatus.LOADING);
      List<FriendSuggestEntity> suggestFriends = [];
      final response = await repository?.getSuggestFriends(token, 0, 20);
      suggestFriends = response!.data!.listUsers ?? [];
      var newData = suggestFriends.asMap()
        .map((index, data) => MapEntry(
            index,
            ListFriendModel(
                id: data.userId,
                createdAt: "2019-10-07T13:50:11.633Z",
                name: data.username,
                imageAvatarUrl: data.avatar ?? AppImages.icSignupIntro,
                shortDescription: "",
                isActive: index % 2 == 0 ? true : false,
                stories: [
                  StoryModel(text: "Story $index", imageUrl: null),
                  StoryModel(text: null, imageUrl: AppImages.icEmotion),
                  StoryModel(text: null, imageUrl: AppImages.testImagePost),
                ],
                partner: PartnerModel(id: data.userId, username: data.username, avatar: data.avatar ?? AppImages.icSignupIntro),
                lastMessage: LastMessageModel(message: "", created: "")
          )))
        .values
        .toList();
      emit(state.copyWith(
        friendList: newData
      ));
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
      if (error is DioError) {
        print("error");
      }
      emit(state.copyWith(
        friendList: friendList
      ));
    }
  }

  Future<void> createConversation(
    ListFriendModel listFriendModel
  ) async {
    String? token = await SharedPreferencesHelper.getToken();
    String? id = await SharedPreferencesHelper.getUserId();
    if (friendList.contains(listFriendModel)) {
      return;
    }
    try {
      loadingController.sink.add(LoadStatus.LOADING);
      final listConversations =
          await repository?.getListConversation(token!, 0, 100);
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
      if (error is DioError) {
        print("error");
      }
      await repository?.createConversation(token, id, id, listFriendModel.partner!.id);
      return;
    }
    try {
      loadingController.sink.add(LoadStatus.LOADING);
      final listConversations =
          await repository?.getListConversation(token!, 0, 100);
      for (var i = 0; i < listConversations!.data!.length; i++) {
        if (listConversations.data![i].partner!.id == listFriendModel.partner!.id) {
          return;
        }
      }
      await repository?.createConversation(token, id, id, listFriendModel.partner!.id);
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
