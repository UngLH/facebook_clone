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

  @override
  Future<void> close() {
    navigatorController.close();
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(phoneNumber: "", password: ""));
  }

  Future<void> signIn(String phoneNumber, String password) async {
    try {
      final result = await repository!.authLogin(phoneNumber, password);

      /// save Token to Shared Preferences
      SharedPreferencesHelper.setToken(result['data']['token']);

      emit(state.copyWith(loadingStatus: LoadingStatus.SUCCESS));
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data['details'] == "phoneNumber" ||
            error.response!.data['details'] == "password") {
          showMessageController.sink
              .add("Phone number or Password is incorrect");
        }
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
