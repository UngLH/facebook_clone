import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:facebook/models/entities/weather/weather_response.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AuthRepository authRepository;
  AppCubit({
    required this.authRepository,

  }) : super(AppState());

  final showDialogController = PublishSubject<String>();

  @override
  Future<void> close() {
    showDialogController.close();
    return super.close();
  }
}
