part of 'edit_post_cubit.dart';

class EditPostState extends Equatable {
  final LoadStatus? loadingStatus;
  final String? described;
  final String? status;
  final List<String>? listImageDeleteId;
  EditPostState(
      {this.loadingStatus,
      this.described,
      this.status,
      this.listImageDeleteId});

  EditPostState copyWith(
      {LoadStatus? loadingStatus,
      String? described,
      String? status,
      List<String>? listImageDeleteId}) {
    return EditPostState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        described: described ?? this.described,
        status: status ?? this.status,
        listImageDeleteId: listImageDeleteId ?? this.listImageDeleteId);
  }

  @override
  List<Object?> get props =>
      [loadingStatus, described, status, listImageDeleteId];
}
