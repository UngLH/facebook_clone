part of 'signup_cubit.dart';

class SignUpState extends Equatable {
  LoadingStatus? loadingStatus;
  String? phoneNumber;
  String? password;
  String? fullName;

  SignUpState(
      {this.loadingStatus,
      this.phoneNumber = "",
      this.password = "",
      this.fullName = ""});

  SignUpState copyWith(
      {LoadingStatus? loadingStatus,
      String? phoneNumber,
      String? password,
      String? fullName}) {
    return SignUpState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        password: password ?? this.password,
        fullName: fullName ?? this.fullName);
  }

  @override
  List<Object?> get props => [loadingStatus, phoneNumber, password, fullName];
}
