import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

enum LoginNavigator {
  OPEN_HOME,
}

class LoginCubit extends Cubit<LoginState> {
  AuthRepository? repository;

  LoginCubit({this.repository}) : super(const LoginState());

  final navigatorController = PublishSubject<LoginNavigator>();
  final showMessageController = PublishSubject<String>();
  final loadingController = PublishSubject<LoadingStatus>();

  @override
  Future<void> close() {
    navigatorController.close();
    loadingController.close();
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(phoneNumber: "", password: ""));
  }

  Future<void> signIn(String phoneNumber, String password) async {
    loadingController.sink.add(LoadingStatus.LOADING);
    try {
      final result = await repository!.authLogin(phoneNumber, password);

      /// save Token to Shared Preferences
      SharedPreferencesHelper.setToken(
          result['data']['token'],
          result['data']['id'],
          result['data']['username'] ?? "Người dùng facebook");

      loadingController.sink.add(LoadingStatus.SUCCESS);
    } catch (error) {
      logger.e(error);
      loadingController.sink.add(LoadingStatus.FAILURE);
      if (error is DioError) {
        if (error.response!.data['details'] == "phoneNumber" ||
            error.response!.data['details'] == "password") {}
      }
    }
  }

  void usernameChange(String username) {
    emit(state.copyWith(phoneNumber: username));
  }

  void passChange(String pass) {
    emit(state.copyWith(password: pass));
  }
}
