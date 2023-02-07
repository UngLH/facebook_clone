import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/commons/share_preferences_helper.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'change_password_state.dart';

enum LoginNavigator {
  OPEN_HOME,
}

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  AuthRepository? repository;

  ChangePasswordCubit({this.repository}) : super(const ChangePasswordState());

  final navigatorController = PublishSubject<LoginNavigator>();
  final showMessageController = PublishSubject<String>();
  final loadingController = PublishSubject<LoadStatus>();

  @override
  Future<void> close() {
    navigatorController.close();
    loadingController.close();
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(phoneNumber: "", password: ""));
  }

  Future<void> changePassword(String oldPass, String newPass) async {
    loadingController.sink.add(LoadStatus.LOADING);
    String? token = await SharedPreferencesHelper.getToken();
    try {
      await repository!.changePassword(token, oldPass, newPass);
      loadingController.sink.add(LoadStatus.SUCCESS);
    } catch (error) {
      logger.e(error);
      loadingController.sink.add(LoadStatus.FAILURE);
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
