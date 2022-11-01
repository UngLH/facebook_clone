part of 'login_cubit.dart';

enum LoadingStatus {
  INITIAL,
  LOADING,
  SUCCESS,
  FAILURE,
  USERNAME_PASSWORD_INVALID,
}

class LoginState extends Equatable {
  final LoadingStatus? loadingStatus;
  final String? phoneNumber;
  final String? password;

  const LoginState(
      {this.loadingStatus = LoadingStatus.INITIAL,
        this.phoneNumber = "",
        this.password = "", });


  LoginState copyWith({
    LoadingStatus? loadingStatus,
    String? phoneNumber,
    String? password,
  }) {
    return  LoginState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [
    LoadingStatus,
    phoneNumber,
    password,
  ];
}
