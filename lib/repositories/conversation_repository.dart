import 'dart:io';

import 'package:facebook/network/api_client_facebook.dart';

import '../models/entities/conversations/list_friend_model.dart';

abstract class ConversationRepository {
  Future<ListConversationResponse> getListConversation(
      String? token, int? index, int? count);
}

class ConversationRepositoryImpl extends ConversationRepository {
  ApiClient? _apiClientFacebook;

  ConversationRepositoryImpl(ApiClient? client) {
    _apiClientFacebook = client;
  }

  @override
  Future<ListConversationResponse> getListConversation(
      String? token, int? index, int? count) {
    return _apiClientFacebook!.getListConversation(token, index, count);
  }
}
