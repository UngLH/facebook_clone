import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/post/post_response_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  PostRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  HomePageCubit({this.repository}) : super(HomePageState());

  @override
  Future<void> close() {
    loadingController.close();
    return super.close();
  }

  Future<void> getListPost() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    List<PostResponseEntity> listPost = [];
    try {
      final response = await repository?.getListPosts(token, 0, 0, 20);
      listPost = response!.data!.posts ?? [];
      for (var i = 0; i < response.data!.posts!.length; i++) {
        if (response.data!.posts![i].isBlocked == "1") {
          listPost.removeAt(i);
        }
        emit(state.copyWith(
            loadingStatus: LoadStatus.SUCCESS, listPost: listPost));
      }
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state.copyWith(loadingStatus: LoadStatus.EMPTY));
        } else if (error.response!.data["message"] == "Token is invalid") {
          loadingController.sink.add(LoadStatus.TOKEN_INVALID);
        } else {
          emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
        }
      }
    }
  }

  Future<void> likePost(String? postId) async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      await repository?.likePost(token, postId);
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> delPost(String? postId) async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      await repository?.delPost(token, postId);
      await getListPost();
    } catch (error) {
      logger.e(error);
    }
  }
}
