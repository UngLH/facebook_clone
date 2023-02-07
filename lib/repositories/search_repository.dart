import 'package:facebook/models/entities/post/post_search_entity.dart';
import 'package:facebook/models/entities/search/search_entity.dart';
import 'package:facebook/network/api_client_facebook.dart';

abstract class SearchRepository {
  Future<SavedSearchResponse> getSavedSearch(
      String? token, int? index, int? count);
  Future<dynamic> delSavedSearch(String? token, String? all, String? searchId);
  Future<PostSearchResponse> search(String? token, String? keyword);
}

class SearchRepositoryImpl extends SearchRepository {
  ApiClient? _apiClientFacebook;
  SearchRepositoryImpl(ApiClient? client) {
    _apiClientFacebook = client;
  }

  @override
  Future<SavedSearchResponse> getSavedSearch(
      String? token, int? index, int? count) {
    return _apiClientFacebook!.getSavedSearch(token, index, count);
  }

  @override
  Future delSavedSearch(String? token, String? all, String? searchId) {
    // TODO: implement delSavedSearch
    return _apiClientFacebook!.delSavedSearch(token, all, searchId);
  }

  @override
  Future<PostSearchResponse> search(String? token, String? keyword) {
    return _apiClientFacebook!.search(token, 0, 20, keyword);
  }
}
