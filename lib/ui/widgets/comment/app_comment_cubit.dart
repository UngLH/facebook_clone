import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/entities/comment/comment_entity.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/post_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'app_comment_state.dart';

class AppCommentCubit extends Cubit<AppCommentState> {
  PostRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  AppCommentCubit({this.repository}) : super(AppCommentState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getListComments(String? postId, int? index, int? count) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING, listComments: []));
    try {
      final response =
          await repository!.getListComment(token, postId, index, count);
      print(response);
      emit(state.copyWith(
          listComments: response.data, loadingStatus: LoadStatus.SUCCESS));
    } catch (error) {
      if (error is DioError) {
        if (error.response!.data["message"] == "No data or end of list data") {
          emit(state.copyWith(loadingStatus: LoadStatus.EMPTY));
        } else {
          emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
        }
      }
    }
  }

  Future<void> setComment(String? postId, String? comment) async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      emit(state.copyWith(loadingStatus: LoadStatus.SUCCESS));
      await repository!.setComment(token, postId, comment, 0, 20);
      getListComments(postId, 0, 20);
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
    }
  }
}
