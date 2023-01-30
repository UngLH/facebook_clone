import 'dart:io';

import 'package:facebook/models/entities/comment/comment_entity.dart';
import 'package:facebook/models/entities/post/post_response_request.dart';
import 'package:facebook/network/api_client_facebook.dart';

abstract class PostRepository {
  Future<dynamic> addPost(String accessToken, String described, String status,
      List<File> images, List<File> videos);
  Future<dynamic> delPost(String? accessToken, String? postId);
  Future<PostResponseRequest> getListPosts(
      String? token, int? lastId, int? index, int? count);
  Future<dynamic> likePost(String? accessToken, String? postId);
  Future<CommentResponseEntity> getListComment(
      String? accessToken, String? postId, int? index, int? count);
  Future<dynamic> setComment(String? accessToken, String? postId,
      String? comment, int? index, int? count);
}

class PostRepositoryImpl extends PostRepository {
  ApiClient? _apiClientFacebook;
  PostRepositoryImpl(ApiClient? client) {
    _apiClientFacebook = client;
  }

  @override
  Future<dynamic> addPost(String accessToken, String described, String status,
      List<File> images, List<File> videos) {
    return _apiClientFacebook!
        .addPost(accessToken, described, status, images, videos);
  }

  @override
  Future<PostResponseRequest> getListPosts(
      String? token, int? lastId, int? index, int? count) {
    return _apiClientFacebook!.getListPosts(token, lastId, index, count);
  }

  @override
  Future likePost(String? accessToken, String? postId) {
    return _apiClientFacebook!.likePost(accessToken, postId);
  }

  @override
  Future<CommentResponseEntity> getListComment(
      String? accessToken, String? postId, int? index, int? count) {
    return _apiClientFacebook!
        .getListComments(accessToken, postId, index, count);
  }

  @override
  Future setComment(String? accessToken, String? postId, String? comment,
      int? index, int? count) {
    return _apiClientFacebook!
        .setComment(accessToken, postId, comment, index, count);
  }

  @override
  Future delPost(String? accessToken, String? postId) {
    return _apiClientFacebook!.delPost(accessToken, postId);
  }
}
