import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/friend/friend_block_entity.dart';
import 'package:facebook/repositories/friend_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:facebook/utils/logger.dart';
import 'package:facebook/models/enums/load_status.dart';
import 'package:rxdart/rxdart.dart';
import 'package:facebook/commons/share_preferences_helper.dart';

part './list_block_state.dart';

class ListBlockCubit extends Cubit<ListBlockState> {
  FriendRepository? repository;
  final loadingController = PublishSubject<LoadStatus>();

  ListBlockCubit({this.repository}) : super(ListBlockState());

  @override
  Future<void> close() {
    return super.close();
  }

  Future<void> getListBlocks() async {
    String? token = await SharedPreferencesHelper.getToken();
    emit(state.copyWith(loadingStatus: LoadStatus.LOADING));
    try {
      final response = await repository!.getListBlock(token, 0, 20);
      emit(state.copyWith(
          loadingStatus: LoadStatus.SUCCESS, listBlocks: response.data));
    } catch (error) {
      emit(state.copyWith(loadingStatus: LoadStatus.FAILURE));
      logger.e(error);
    }
  }
}
