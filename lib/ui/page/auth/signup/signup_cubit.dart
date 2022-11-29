import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';
import 'package:facebook/utils/logger.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  AuthRepository? authRepository;

  SignUpCubit({
    this.authRepository,
  }) : super(SignUpState());

  @override
  Future<void> close() {
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
    try {
      emit(state.copyWith(loadingStatus: LoadingStatus.LOADING));
      final result = await authRepository!
          .signUp(state.phoneNumber ?? '', state.password ?? '');
      print(result);
      emit(state.copyWith(loadingStatus: LoadingStatus.SUCCESS));
    } catch (error) {
      logger.e(error);
      if (error is DioError) {
        emit(state.copyWith(loadingStatus: LoadingStatus.FAILURE));
      }
    }
  }
}
