part of './list_block_cubit.dart';

class ListBlockState extends Equatable {
  LoadStatus? loadingStatus;
  List<FriendBlockEntity>? listBlocks;
  ListBlockState({
    this.loadingStatus,
    this.listBlocks,
  });

  @override
  List<Object?> get props => [loadingStatus, listBlocks];

  ListBlockState copyWith({
    LoadStatus? loadingStatus,
    List<FriendBlockEntity>? listBlocks,
  }) {
    return ListBlockState(
        loadingStatus: loadingStatus ?? this.loadingStatus,
        listBlocks: listBlocks ?? this.listBlocks);
  }
}
