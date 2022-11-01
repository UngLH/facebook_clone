import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'login_state.dart';

enum LoginNavigator {
  OPEN_HOME,
}

class LoginCubit extends Cubit<LoginState> {
  AuthRepository? repository;

  LoginCubit({this.repository})
      : super(const LoginState());

  final navigatorController = PublishSubject<LoginNavigator>();

  @override
  Future<void> close() {
    navigatorController.close();
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(phoneNumber: "", password: ""));
  }
 Future <void>  signIn(String phoneNumber, String password) async {
    // try {
      final result = await repository!.authLogin("0858693350","ung1234");
      print(result);
      emit(state.copyWith(loadingStatus: LoadingStatus.SUCCESS));
    // } catch (error) {
    //   logger.e(error);
    //   if (error is DioError) {
    //
    //   }
    // }
  }

  void usernameChange(String username) {
    emit(state.copyWith(phoneNumber: username));
  }

  void passChange(String pass) {
    emit(state.copyWith(password: pass));
  }
}
