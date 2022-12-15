import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:facebook/models/entities/conversations/chat_detail_model.dart';
import 'package:facebook/models/entities/conversations/list_friend_model.dart';
import 'package:facebook/repositories/auth_repository.dart';
import 'package:facebook/ui/page/auth/login/login_cubit.dart';

part 'chat_detail_state.dart';

class ChatDetailCubit extends Cubit<ChatDetailState> {
  AuthRepository? authRepository;

  ChatDetailCubit({
    this.authRepository,
  }) : super(ChatDetailState(chatDetailList: chatDetailList.reversed.toList()));

  @override
  Future<void> close() {
    return super.close();
  }

  void clearInformation() {
    emit(state.copyWith(messageValue: ""));
  }

  void messageValueChange(String? messageValue) {
    // ignore: avoid_print
    emit(state.copyWith(
      messageValue: messageValue,
    ));
  }

  bool isTyping() {
    if (state.messageValue!.isNotEmpty) {
      return true;
    }
    return false;
  }

  void sendMessage() {
    List<ChatDetailModel>? _chatDetailList = state.chatDetailList;
    int index = state.chatDetailList!.length;
    _chatDetailList!.insert(
      0,
      ChatDetailModel(
        id: index,
        createdAt: "2019-10-07T13:50:11.633Z",
        dialog_id: "$index",
        conversation_id: "$index",
        message: state.messageValue,
        isYour: index % 3 == 0 ? true : false,
      )
    );
    emit(state.copyWith(
      messageValue: "",
      chatDetailList: _chatDetailList
    ));
  }
}
