import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/post/post_response_entity.dart';
import 'package:facebook/models/entities/post/post_search_entity.dart';
import 'package:facebook/models/entities/search/search_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/repositories/search_repository.dart';
import 'package:facebook/utils/logger.dart';

part 'find_page_state.dart';

class FindPageCubit extends Cubit<FindPageState> {
  SearchRepository? repository;
  PostRepository? postRepository;

  FindPageCubit({this.repository, this.postRepository})
      : super(FindPageState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getSavedSearch() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository!.getSavedSearch(token, 0, 20);
      emit(state.copyWith(
          loadingStatus: LoadStatus.SUCCESS, listSavedSearch: response.data));
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state
              .copyWith(loadingStatus: LoadStatus.EMPTY, listSavedSearch: []));
        } else {
          emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
        }
      }
    }
  }

  Future<void> delSavedSearch(String? searchId, String? isAll) async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      await repository!.delSavedSearch(token, isAll, searchId);
      getSavedSearch();
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> search(String? keyword) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingPostStatus: LoadStatus.LOADING));
    try {
      final response = await repository!.search(token, keyword);
      emit(state.copyWith(
          loadingPostStatus: LoadStatus.SUCCESS, posts: response.data));
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state.copyWith(loadingPostStatus: LoadStatus.EMPTY, posts: []));
        } else {
          emit(state.copyWith(loadingPostStatus: LoadStatus.FAILURE));
        }
      }
    }
  }

  Future<void> likePost(String? postId) async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      await postRepository?.likePost(token, postId);
    } catch (error) {
      logger.e(error);
    }
  }

  Future<void> delPost(String? postId, String? keyword) async {
    String? token = await SharedPreferencesHelper.getToken();
    try {
      await postRepository?.delPost(token, postId);
      await search(keyword);
    } catch (error) {
      logger.e(error);
    }
  }
}
