part of 'find_page_cubit.dart';

class FindPageState extends Equatable {
  LoadStatus? loadingStatus;
  LoadStatus? loadingPostStatus;
  List<SearchEntity>? listSavedSearch;
  List<PostSearchEntity>? posts;

  FindPageState(
      {this.loadingStatus = LoadStatus.LOADING,
      this.listSavedSearch,
      this.posts,
      this.loadingPostStatus});

  FindPageState copyWith(
      {LoadStatus? loadingStatus,
      LoadStatus? loadingPostStatus,
      List<SearchEntity>? listSavedSearch,
      List<PostSearchEntity>? posts}) {
    return FindPageState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listSavedSearch: listSavedSearch ?? this.listSavedSearch,
        posts: posts ?? this.posts,
        loadingPostStatus: loadingPostStatus ?? this.loadingPostStatus);
  }

  @override
  List<Object?> get props =>
      [loadingStatus, listSavedSearch, posts, loadingPostStatus];
}
