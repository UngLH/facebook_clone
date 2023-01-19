import 'dart:io';

import 'package:dio/dio.dart';
import 'package:facebook/configs/app_configs.dart';
import 'package:facebook/models/entities/comment/comment_entity.dart';
import 'package:facebook/models/entities/post/post_response_request.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client_facebook.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST("/it4788/auth/login?phonenumber={phoneNumber}&password={password}")
  Future<dynamic> authLogin(@Path("phoneNumber") String? phoneNumber,
      @Path("password") String? password);

  @POST("/it4788/auth/signup?phonenumber={phoneNumber}&password={password}")
  Future<dynamic> signUp(@Path("phoneNumber") String? phoneNumber,
      @Path("password") String? password);

  @POST(
      "/it4788/auth/check_verify_code?phonenumber={phoneNumber}&code_verify={code}")
  Future<dynamic> verifyCode(
      @Path("phoneNumber") String? phoneNumber, @Path("code") String? code);

  //update infor and avatar
  @POST(
      "/it4788/auth/change_info_after_signup?token={token}&username={username}")
  Future<dynamic> createUserInforAndAvt(
    @Path("token") String? token,
    @Path("username") String? username,
  );

  /// Post

  @POST(
      "/it4788/post/get_list_posts?token={token}&last_id={last_id}&index={index}&count={count}")
  Future<PostResponseRequest> getListPosts(
    @Path("token") String? token,
    @Path("last_id") int? lastId,
    @Path("index") int? index,
    @Path("count") int? count,
  );
  @POST(
      "/it4788/post/add_post?token={token}&described={described}&status={status}")
  @MultiPart()
  Future<dynamic> addPost(
      @Path("token") String? token,
      @Path("described") String? described,
      @Path("status") String? status,
      @Part(name: "image") List<File>? images,
      @Part(name: "video") List<File>? videos);

  @POST("/it4788/like/like?token={token}&id={postId}")
  Future<dynamic> likePost(
      @Path("token") String? token, @Path("postId") String? postId);

  @POST(
      "/it4788/comment/get_comment?token={token}&id={postId}&index={index}&count={count}")
  Future<CommentResponseEntity> getListComments(
      @Path("token") String? token,
      @Path("postId") String? postId,
      @Path("index") int? index,
      @Path("count") int? count);
  @POST(
      "/it4788/comment/set_comment?token={token}&id={postId}&comment={comment}&index={index}&count={count}")
  Future<dynamic> setComment(
      @Path("token") String? token,
      @Path("postId") String? postId,
      @Path("comment") String? comment,
      @Path("index") int? index,
      @Path("count") int? count);
}
