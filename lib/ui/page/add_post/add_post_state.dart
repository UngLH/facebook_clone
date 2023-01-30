part of 'add_post_cubit.dart';

class AddPostState extends Equatable {
  AddPostState({this.loadingStatus, this.described, this.status});
  final LoadStatus? loadingStatus;
  final String? described;
  final String? status;

  AddPostState copyWith({
    LoadStatus? loadingStatus,
    String? described,
    String? status,
  }) {
    return AddPostState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        described: described ?? this.described,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [loadingStatus, described, status];
}
