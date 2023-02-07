import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/friend/friend_request_entity.dart';
import 'package:facebook/models/entities/user/user_profile_entity.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:facebook/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/utils/logger.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook/commons/share_preferences_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  FriendRepository? friendRepository;
  UserRepository? userRepository;
  final loadingController = PublishSubject<LoadStatus>();

  ProfileCubit({this.friendRepository, this.userRepository})
      : super(ProfileState());

  @override
  Future<void> close() {
    loadingController.close();
    return super.close();
  }

  Future<void> getListFriends(String? userId) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await friendRepository!.getListFriends(token, 0, 20);
      emit(state.copyWith(
          loadingStatus: LoadStatus.SUCCESS,
          listFriends: response.data!.requestList));
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      logger.e(error);
    }
  }

  Future<void> getUserProfile(String? userId) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadProfileStatus: LoadStatus.LOADING));
    loadingController.sink.add(LoadStatus.LOADING);
    try {
      final response = await userRepository!.getUserInfor(token, userId);
      loadingController.sink.add(LoadStatus.SUCCESS);
      emit(state.copyWith(
          loadProfileStatus: LoadStatus.SUCCESS, userProfile: response.data));
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
    }
  }

  Future<void> setUserProfile(
      {String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      String? link}) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadProfileStatus: LoadStatus.LOADING));
    loadingController.sink.add(LoadStatus.LOADING);
    try {
      await userRepository!.setUserInfo(
          token: token,
          username: username,
          address: address,
          description: description,
          city: city,
          country: country,
          link: link);
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
    }
  }

  Future<void> setUserAvt(File? image, String? userId) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadProfileStatus: LoadStatus.LOADING));
    loadingController.sink.add(LoadStatus.LOADING);
    try {
      await userRepository!.setUserAvatar(
          token: token,
          username: state.userProfile!.username,
          address: state.userProfile!.address,
          description: state.userProfile!.description,
          city: state.userProfile!.city,
          country: state.userProfile!.country,
          link: state.userProfile!.link,
          image: image);
      loadingController.sink.add(LoadStatus.SUCCESS);
      getUserProfile(userId);
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
    }
  }

  Future<void> setUserBackground(File? image, String? userId) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadProfileStatus: LoadStatus.LOADING));
    loadingController.sink.add(LoadStatus.LOADING);
    try {
      await userRepository!.setUserBackground(
          token: token,
          username: state.userProfile!.username,
          address: state.userProfile!.address,
          description: state.userProfile!.description,
          city: state.userProfile!.city,
          country: state.userProfile!.country,
          link: state.userProfile!.link,
          background: image);
      loadingController.sink.add(LoadStatus.SUCCESS);
      getUserProfile(userId);
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
    }
  }
}
