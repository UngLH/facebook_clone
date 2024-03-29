import 'dart:io';

import 'package:facebook/models/entities/friend/friend_block_entity.dart';
import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/models/entities/friend/friend_request_entity.dart';
import 'package:facebook/network/api_client_facebook.dart';

abstract class FriendRepository {
  Future<FriendSuggestResponse> getSuggestFriends(
      String? token, int? index, int? count);

  Future<RequestFriendResponse> getRequestFriends(
      String? token, int? index, int? count);

  Future<dynamic> setAcceptFriend(
      String? token, String? userId, String? isAccept);

  Future<dynamic> setRequestFriend(String? token, String? userId);

  Future<dynamic> setBlock(String? token, String? userId, String type);

  Future<ListBlockResponse> getListBlock(String? token, int? index, int count);

  Future<RequestFriendResponse> getListFriends(
      String? token, int? index, int count);
}

class FriendRepositoryImpl extends FriendRepository {
  ApiClient? _apiClientFacebook;
  FriendRepositoryImpl(ApiClient? client) {
    _apiClientFacebook = client;
  }

  @override
  Future<FriendSuggestResponse> getSuggestFriends(
      String? token, int? index, int? count) {
    return _apiClientFacebook!.getSuggestedFriend(token, index, count);
  }

  @override
  Future<RequestFriendResponse> getRequestFriends(
      String? token, int? index, int? count) {
    return _apiClientFacebook!.getRequestFriends(token, index, count);
  }

  @override
  Future setAcceptFriend(String? token, String? userId, String? isAccept) {
    return _apiClientFacebook!.setAcceptFriend(token, userId, isAccept);
  }

  @override
  Future setRequestFriend(String? token, String? userId) {
    return _apiClientFacebook!.setRequestFriend(token, userId);
  }

  @override
  Future setBlock(String? token, String? userId, String type) {
    return _apiClientFacebook!.setBlock(token, userId, type);
  }

  @override
  Future<ListBlockResponse> getListBlock(String? token, int? index, int count) {
    return _apiClientFacebook!.getListBlocks(token, index, count);
  }

  @override
  Future<RequestFriendResponse> getListFriends(
      String? token, int? index, int count) {
    return _apiClientFacebook!.getListFriends(token, index, count);
  }

  // @override
  // Future<FriendEntity> getUserFriends(
  //     String? token, String? userId, int? index, int count) {
  //   return _apiClientFacebook!.getUserFriends(token, userId, index, count);
  // }
}
