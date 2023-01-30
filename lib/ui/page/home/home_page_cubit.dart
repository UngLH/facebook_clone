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
    return super.close();
  }

  Future<void> getListPost() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository?.getListPosts(token, 0, 0, 20);
      if (response != null) {
        emit(state.copyWith(
            loadingStatus: LoadStatus.SUCCESS, listPost: response.data!.posts));
        print(state.loadingStatus);
      }
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        print(error.response!.data["message"]);
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state.copyWith(loadingStatus: LoadStatus.EMPTY));
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
    } catch (error) {
      logger.e(error);
    }
  }
}
