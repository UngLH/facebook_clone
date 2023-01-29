import 'dart:io';

import 'package:facebook/network/api_client_facebook.dart';
import 'package:facebook/storage/share_preferences_helper.dart';

import '../models/entities/conversations/list_friend_model.dart';

abstract class AuthRepository {
  //
  Future<void> removeToken();
  Future<dynamic> authLogin(String phoneNumber, String password);
  Future<dynamic> signUp(String phoneNumber, String password);
  Future<dynamic> verifyCode(String phoneNumber, String verifyCode);
  Future<dynamic> updateUserInfor({String? token, String? username});
  Future<ListConversationResponse> getListConversation(
      String? token, int? index, int? count);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient? _apiClientFacebook;

  final accessToken = SharedPreferencesHelper.getToken().toString();
  AuthRepositoryImpl(ApiClient? client) {
    _apiClientFacebook = client;
  }
  @override
  Future<void> removeToken() async {
    await SharedPreferencesHelper.removeToken();
  }

  @override
  Future<dynamic> authLogin(String phoneNumber, String password) async {
    return _apiClientFacebook!.authLogin(phoneNumber, password);
  }

  @override
  Future<dynamic> signUp(String phoneNumber, String password) async {
    return _apiClientFacebook!.signUp(phoneNumber, password);
  }

  @override
  Future verifyCode(String phoneNumber, String verifyCode) {
    return _apiClientFacebook!.verifyCode(phoneNumber, verifyCode);
  }

  @override
  Future updateUserInfor({String? token, String? username}) {
    return _apiClientFacebook!.createUserInforAndAvt(token, username);
  }

  @override
  Future<ListConversationResponse> getListConversation(
      String? token, int? index, int? count) {
    return _apiClientFacebook!.getListConversation(token, index, count);
  }
}
