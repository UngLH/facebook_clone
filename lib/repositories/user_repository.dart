import 'dart:io';

import 'package:facebook/models/entities/user/user_profile_entity.dart';
import 'package:facebook/network/api_client_facebook.dart';
import 'package:facebook/storage/share_preferences_helper.dart';

abstract class UserRepository {
  Future<ProfileResponse> getUserInfor(String? token, String? userId);
  Future<dynamic> setUserInfo(
      {String? token,
      String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      String? link});
  Future<dynamic> setUserAvatar(
      {String? token,
      String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      String? link,
      File? image});
  Future<dynamic> setUserBackground(
      {String? token,
      String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      String? link,
      File? background});
}

class UserRepositoryImpl extends UserRepository {
  ApiClient? _apiClientFacebook;

  final accessToken = SharedPreferencesHelper.getToken().toString();
  UserRepositoryImpl(ApiClient? client) {
    _apiClientFacebook = client;
  }

  @override
  Future<ProfileResponse> getUserInfor(String? token, String? userId) {
    return _apiClientFacebook!.getUserInfor(token, userId);
  }

  @override
  Future setUserInfo({
    String? token,
    String? username,
    String? description,
    String? address,
    String? city,
    String? country,
    String? link,
  }) {
    return _apiClientFacebook!.setUserInfor(
        token, username, description, address, city, country, link);
  }

  @override
  Future setUserAvatar(
      {String? token,
      String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      String? link,
      File? image}) {
    return _apiClientFacebook!.setUserAvt(
        token, username, description, address, city, country, link, image);
  }

  @override
  Future setUserBackground(
      {String? token,
      String? username,
      String? description,
      String? address,
      String? city,
      String? country,
      String? link,
      File? background}) {
    return _apiClientFacebook!.setUserBackground(
        token, username, description, address, city, country, link, background);
  }
}
