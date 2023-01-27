import 'package:facebook/models/entities/friend/friend_entity.dart';
import 'package:facebook/network/api_client_facebook.dart';

abstract class FriendRepository {
  Future<FriendSuggestResponse> getSuggestFriends(
      String? token, int? index, int? count);
  Future<FriendSuggestResponse> getRequestFriends(
      String? token, int? index, int? count);
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
  Future<FriendSuggestResponse> getRequestFriends(
      String? token, int? index, int? count) {
    return _apiClientFacebook!.getRequestFriends(token, index, count);
  }
}
