part of 'home_page_cubit.dart';

class HomePageState extends Equatable {
  LoadStatus? loadingStatus;
  List<PostResponseEntity>? listPost;

  HomePageState({this.loadingStatus = LoadStatus.LOADING, this.listPost});

  HomePageState copyWith(
      {LoadStatus? loadingStatus, List<PostResponseEntity>? listPost}) {
    return HomePageState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listPost: listPost ?? this.listPost);
  }

  @override
  List<Object?> get props => [loadingStatus, listPost];
}
