import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  AuthRepository? authRepository;
  final loadingController = PublishSubject<LoadingStatus>();

  SignUpCubit({
    this.authRepository,
  }) : super(SignUpState());

  @override
  Future<void> close() {
    loadingController.close();
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(phoneNumber: "", password: "", fullName: ""));
  }

  void phoneChange(String? phoneNumber) {
    emit(state.copyWith(phoneNumber: phoneNumber));
  }

  void passwordChange(String password) {
    emit(state.copyWith(password: password));
  }

  void fullNameChange(String firstname, String lastName) {
    emit(state.copyWith(fullName: firstname + " " + lastName));
  }

  Future<void> signUp() async {
    loadingController.sink.add(LoadingStatus.LOADING);
    try {
      final result = await authRepository!
          .signUp(state.phoneNumber ?? '', state.password ?? '');
      await authRepository!
          .verifyCode(state.phoneNumber ?? "", result['data']['verifyCode']);
      final loginResult = await authRepository!
          .authLogin(state.phoneNumber ?? '', state.password ?? '');
      final token = loginResult['data']['token'];
      await authRepository!
          .updateUserInfor(token: token, username: state.fullName);
      loadingController.sink.add(LoadingStatus.SUCCESS);
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        if (error.response!.data["message"] == "User existed") {
          loadingController.sink.add(LoadingStatus.USER_EXIST);
        } else {
          loadingController.sink.add(LoadingStatus.FAILURE);
        }
      }
    }
  }
}
