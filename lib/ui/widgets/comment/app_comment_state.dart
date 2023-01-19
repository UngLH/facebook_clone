part of 'app_comment_cubit.dart';

class AppCommentState extends Equatable {
  LoadStatus? loadingStatus;
  List<CommentEntity>? listComments;

  AppCommentState({this.loadingStatus = LoadStatus.LOADING, this.listComments});

  AppCommentState copyWith(
      {LoadStatus? loadingStatus, List<CommentEntity>? listComments}) {
    return AppCommentState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listComments: listComments ?? this.listComments);
  }

  @override
  List<Object?> get props => [loadingStatus, listComments];
}
