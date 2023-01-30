part of 'chat_detail_cubit.dart';

class ChatDetailState extends Equatable {
  LoadingStatus? loadingStatus;
  String? messageValue;
  List<ChatDetailModel>? chatDetailList;

  ChatDetailState({
    this.loadingStatus,
    this.messageValue = "",
    this.chatDetailList,
  });

  ChatDetailState copyWith({
    LoadingStatus? loadingStatus,
    String? messageValue,
    List<ChatDetailModel>? chatDetailList,
  }) {
    return ChatDetailState(
      loadingStatus: loadingStatus ?? this.loadingStatus,
      messageValue: messageValue ?? this.messageValue,
      chatDetailList: chatDetailList ?? this.chatDetailList,
    );
  }

  @override
  List<Object?> get props => [loadingStatus, messageValue, chatDetailList];
}
