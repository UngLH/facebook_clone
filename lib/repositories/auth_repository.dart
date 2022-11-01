import 'package:facebook/network/api_client_facebook.dart';
import 'package:facebook/storage/share_preferences_helper.dart';

abstract class AuthRepository {
  //
  Future<void> removeToken();
  Future<dynamic> authLogin(String phoneNumber, String password);
}

class AuthRepositoryImpl extends AuthRepository {
  ApiClient? _apiClientFacebook;

  final accessToken = SharedPreferencesHelper.getToken().toString();
  AuthRepositoryImpl(ApiClient? client) {
    _apiClientFacebook= client;
  }
  @override
  Future<void> removeToken() async {
    await SharedPreferencesHelper.removeToken();
  }

  @override
  Future<dynamic> authLogin(String phoneNumber, String password) async {
    return _apiClientFacebook!.authLogin();
  }


}
