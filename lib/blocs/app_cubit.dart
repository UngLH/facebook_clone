import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/repositories/post_repository.dart';
import 'package:facebook/repositories/search_repository.dart';
import 'package:facebook/repositories/user_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AuthRepository authRepository;
  PostRepository postRepository;
  UserRepository userRepository;
  SearchRepository searchRepository;

  AppCubit(
      {required this.authRepository,
      required this.postRepository,
      required this.userRepository,
      required this.searchRepository})
      : super(const AppState());

  final showDialogController = PublishSubject<String>();

  @override
  Future<void> close() {
    showDialogController.close();
    return super.close();
  }
}
