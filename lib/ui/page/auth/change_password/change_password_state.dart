part of 'change_password_cubit.dart';

class ChangePasswordState extends Equatable {
  final LoadStatus? loadingStatus;
  final String? oldPassword;
  final String? newPassword;

  const ChangePasswordState({
    this.loadingStatus = LoadStatus.LOADING,
    this.oldPassword = "",
    this.newPassword = "",
  });

  ChangePasswordState copyWith({
    LoadStatus? loadingStatus,
    String? phoneNumber,
    String? password,
  }) {
    return ChangePasswordState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        oldPassword: oldPassword ?? this.oldPassword,
        newPassword: newPassword ?? this.newPassword);
  }

  @override
  List<Object?> get props => [loadingStatus, oldPassword, newPassword];
}
