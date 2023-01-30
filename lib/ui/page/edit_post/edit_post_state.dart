part of 'edit_post_cubit.dart';

class EditPostState extends Equatable {
  EditPostState({this.loadingStatus, this.described, this.status});
  final LoadStatus? loadingStatus;
  final String? described;
  final String? status;

  EditPostState copyWith({
    LoadStatus? loadingStatus,
    String? described,
    String? status,
  }) {
    return EditPostState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        described: described ?? this.described,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [loadingStatus, described, status];
}
