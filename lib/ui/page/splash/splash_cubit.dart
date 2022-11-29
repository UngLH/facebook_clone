import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/storage/share_preferences_helper.dart';
import 'package:rxdart/rxdart.dart';

part 'splash_state.dart';

enum SplashNavigator {
  OPEN_HOME,
  OPEN_LOGIN,
}

class SplashCubit extends Cubit<SplashState> {
  AuthRepository? authRepository;

  final messageController = PublishSubject<String>();
  final navigatorController = PublishSubject<SplashNavigator>();

  SplashCubit({
    this.authRepository,
  }) : super(SplashState());

  void fetchInitialData() async {
    String? token = await SharedPreferencesHelper.getToken();
    print(token);

    ///Check login and fetch profile
    if (token == null) {
      navigatorController.sink.add(SplashNavigator.OPEN_LOGIN);
    } else {
      navigatorController.sink.add(SplashNavigator.OPEN_HOME);
    }
  }

  @override
  Future<void> close() {
    messageController.close();
    navigatorController.close();
    return super.close();
  }
}
