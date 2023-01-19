import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/subjects.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  PostRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  AddPostCubit({this.repository}) : super(AddPostState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> addPost(String described, String status, List<File> images,
      List<File> videos) async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      loadingController.sink.add(LoadStatus.LOADING);
      final result =
          await repository?.addPost(token!, described, status, images, videos);
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      loadingController.sink.add(LoadStatus.FAILURE);
      logger.e(error);
      if (error is DioError) {
        print("error");
      }
    }
  }
}
